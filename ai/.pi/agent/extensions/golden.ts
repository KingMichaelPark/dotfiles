import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";
import { BorderedLoader } from "@mariozechner/pi-coding-agent";
import { complete, type UserMessage, type Model, type Api } from "@mariozechner/pi-ai";
import {
    type Component,
    Editor,
    type EditorTheme,
    Key,
    matchesKey,
    truncateToWidth,
    type TUI,
    visibleWidth,
    wrapTextWithAnsi,
} from "@mariozechner/pi-tui";
import * as fs from "node:fs";
import * as path from "node:path";

interface Section {
    id: string;
    question: string;
    context?: string;
    defaultValue?: string;
}

const BUG_SECTIONS: Section[] = [
    { id: "summary", question: "Summary", context: "Concise description (e.g., [Component] - [Error] when [Action])" },
    { id: "environment", question: "Environment", context: "OS, Browser, Version, Environment (Prod/Staging)" },
    { id: "description", question: "Description", context: "High-level overview of the issue" },
    { id: "steps", question: "Steps to Reproduce", context: "Numbered list of steps" },
    { id: "expected", question: "Expected Result", context: "What should have happened?" },
    { id: "actual", question: "Actual Result", context: "What actually happened?" },
    { id: "analysis", question: "Technical Analysis", context: "Code references, potential root cause" },
    { id: "visuals", question: "Visuals/Logs", context: "Placeholders for screenshots, stack traces" },
    { id: "priority", question: "Severity/Priority", context: "Suggested level based on impact" },
];

const TICKET_SECTIONS: Section[] = [
    { id: "summary", question: "Summary/Title", context: "Clear, concise, prefixed with component" },
    { id: "user_story", question: "User Story", context: "As a [role], I want to [action], so that [value]" },
    { id: "context", question: "Context/Background", context: "Why are we doing this?" },
    { id: "requirements", question: "Technical Requirements", context: "Specific implementation details" },
    { id: "ac", question: "Acceptance Criteria (AC)", context: "Checklist format (Gherkin preferred)" },
    { id: "dod", question: "Definition of Done (DoD)", context: "Standard engineering requirements" },
    { id: "security", question: "Security & Performance", context: "Specific considerations" },
];

class WizardComponent implements Component {
    private sections: Section[];
    private answers: string[];
    private currentIndex: number = 0;
    private editor: Editor;
    private tui: TUI;
    private onDone: (result: Record<string, string> | null) => void;
    private showingConfirmation: boolean = false;

    private cachedWidth?: number;
    private cachedLines?: string[];

    private dim = (s: string) => `\x1b[2m${s}\x1b[0m`;
    private bold = (s: string) => `\x1b[1m${s}\x1b[0m`;
    private cyan = (s: string) => `\x1b[36m${s}\x1b[0m`;
    private green = (s: string) => `\x1b[32m${s}\x1b[0m`;
    private yellow = (s: string) => `\x1b[33m${s}\x1b[0m`;
    private gray = (s: string) => `\x1b[90m${s}\x1b[0m`;

    constructor(sections: Section[], tui: TUI, onDone: (result: Record<string, string> | null) => void) {
        this.sections = sections;
        this.answers = sections.map(s => s.defaultValue || "");
        this.tui = tui;
        this.onDone = onDone;

        const editorTheme: EditorTheme = {
            borderColor: this.dim,
            selectList: {
                selectedBg: (s: string) => `\x1b[44m${s}\x1b[0m`,
                matchHighlight: this.cyan,
                itemSecondary: this.gray,
            },
        };

        this.editor = new Editor(tui, editorTheme);
        this.editor.disableSubmit = true;
        this.editor.onChange = () => {
            this.invalidate();
            this.tui.requestRender();
        };
        if (this.answers[0]) {
            this.editor.setText(this.answers[0]);
        }
    }

    private saveCurrentAnswer(): void {
        this.answers[this.currentIndex] = this.editor.getText();
    }

    private navigateTo(index: number): void {
        if (index < 0 || index >= this.sections.length) return;
        this.saveCurrentAnswer();
        this.currentIndex = index;
        this.editor.setText(this.answers[index] || "");
        this.invalidate();
    }

    private submit(): void {
        this.saveCurrentAnswer();
        const result: Record<string, string> = {};
        for (let i = 0; i < this.sections.length; i++) {
            result[this.sections[i].id] = this.answers[i];
        }
        this.onDone(result);
    }

    invalidate(): void {
        this.cachedWidth = undefined;
        this.cachedLines = undefined;
    }

    handleInput(data: string): void {
        if (this.showingConfirmation) {
            if (matchesKey(data, Key.enter) || data.toLowerCase() === "y") {
                this.submit();
                return;
            }
            if (matchesKey(data, Key.escape) || matchesKey(data, Key.ctrl("c")) || data.toLowerCase() === "n") {
                this.showingConfirmation = false;
                this.invalidate();
                this.tui.requestRender();
                return;
            }
            return;
        }

        if (matchesKey(data, Key.escape) || matchesKey(data, Key.ctrl("c"))) {
            this.onDone(null);
            return;
        }

        if (matchesKey(data, Key.tab)) {
            if (this.currentIndex < this.sections.length - 1) {
                this.navigateTo(this.currentIndex + 1);
                this.tui.requestRender();
            }
            return;
        }
        if (matchesKey(data, Key.shift("tab"))) {
            if (this.currentIndex > 0) {
                this.navigateTo(this.currentIndex - 1);
                this.tui.requestRender();
            }
            return;
        }

        if (matchesKey(data, Key.enter) && !matchesKey(data, Key.shift("enter"))) {
            this.saveCurrentAnswer();
            if (this.currentIndex < this.sections.length - 1) {
                this.navigateTo(this.currentIndex + 1);
            } else {
                this.showingConfirmation = true;
            }
            this.invalidate();
            this.tui.requestRender();
            return;
        }

        this.editor.handleInput(data);
        this.invalidate();
        this.tui.requestRender();
    }

    render(width: number): string[] {
        if (this.cachedLines && this.cachedWidth === width) return this.cachedLines;

        const lines: string[] = [];
        const boxWidth = Math.min(width - 4, 120);
        const contentWidth = boxWidth - 4;

        const horizontalLine = (count: number) => "─".repeat(count);
        const boxLine = (content: string, leftPad: number = 2): string => {
            const paddedContent = " ".repeat(leftPad) + content;
            const contentLen = visibleWidth(paddedContent);
            const rightPad = Math.max(0, boxWidth - contentLen - 2);
            return this.dim("│") + paddedContent + " ".repeat(rightPad) + this.dim("│");
        };

        const padToWidth = (line: string): string => {
            const len = visibleWidth(line);
            return line + " ".repeat(Math.max(0, width - len));
        };

        lines.push(padToWidth(this.dim("╭" + horizontalLine(boxWidth - 2) + "╮")));
        const title = `${this.bold(this.cyan("Golden Wizard"))} ${this.dim(`(${this.currentIndex + 1}/${this.sections.length})`)}`;
        lines.push(padToWidth(boxLine(title)));
        lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));

        // Progress
        const progressParts: string[] = [];
        for (let i = 0; i < this.sections.length; i++) {
            if (i === this.currentIndex) progressParts.push(this.cyan("●"));
            else if (this.answers[i].trim().length > 0) progressParts.push(this.green("●"));
            else progressParts.push(this.dim("○"));
        }
        lines.push(padToWidth(boxLine(progressParts.join(" "))));
        lines.push(padToWidth(this.dim("│") + " ".repeat(boxWidth - 2) + this.dim("│")));

        const s = this.sections[this.currentIndex];
        const questionText = `${this.bold("Field:")} ${s.question}`;
        const wrappedQuestion = wrapTextWithAnsi(questionText, contentWidth);
        for (const line of wrappedQuestion) lines.push(padToWidth(boxLine(line)));

        if (s.context) {
            lines.push(padToWidth(this.dim("│") + " ".repeat(boxWidth - 2) + this.dim("│")));
            const contextText = this.gray(`> ${s.context}`);
            const wrappedContext = wrapTextWithAnsi(contextText, contentWidth - 2);
            for (const line of wrappedContext) lines.push(padToWidth(boxLine(line)));
        }

        lines.push(padToWidth(this.dim("│") + " ".repeat(boxWidth - 2) + this.dim("│")));

        const editorLines = this.editor.render(contentWidth - 6);
        for (let i = 1; i < editorLines.length - 1; i++) {
            lines.push(padToWidth(boxLine((i === 1 ? this.bold("Value: ") : "       ") + editorLines[i])));
        }

        lines.push(padToWidth(this.dim("│") + " ".repeat(boxWidth - 2) + this.dim("│")));

        if (this.showingConfirmation) {
            lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));
            lines.push(padToWidth(boxLine(`${this.yellow("Create file?")} ${this.dim("(Enter/y to confirm, Esc/n to cancel)")}`)));
        } else {
            lines.push(padToWidth(this.dim("├" + horizontalLine(boxWidth - 2) + "┤")));
            lines.push(padToWidth(boxLine(truncateToWidth(`${this.dim("Tab")} next · ${this.dim("Shift+Tab")} prev · ${this.dim("Enter")} confirm · ${this.dim("Esc")} cancel`, contentWidth))));
        }
        lines.push(padToWidth(this.dim("╰" + horizontalLine(boxWidth - 2) + "╯")));

        this.cachedWidth = width;
        this.cachedLines = lines;
        return lines;
    }
}

async function generateWithLLM(ctx: ExtensionContext, prompt: string, template: string): Promise<string> {
    const model = ctx.model;
    if (!model) throw new Error("No model selected");
    const auth = await ctx.modelRegistry.getApiKeyAndHeaders(model);
    if (!auth.ok) throw new Error(auth.error);

    const branch = ctx.sessionManager.getBranch();
    const messages: UserMessage[] = [];
    for (const entry of branch) {
        if (entry.type === "message") {
            messages.push(entry.message as UserMessage);
        }
    }

    messages.push({
        role: "user",
        content: [{ type: "text", text: prompt }],
        timestamp: Date.now()
    });

    const response = await complete(model, {
        systemPrompt: `You are a technical documentation expert. Use the provided context to fill out this template exactly.
Template Structure:
${template}

Return ONLY the completed markdown. Do not include any of the prompt, system instructions, or thinking in your output.`,
        messages,
    }, {
        apiKey: auth.apiKey,
        headers: auth.headers,
        signal: ctx.signal,
    });

    return response.content
        .filter((c): c is { type: "text"; text: string } => c.type === "text")
        .map(c => c.text)
        .join("\n");
}

function saveMarkdown(summary: string, content: string, cwd: string): string {
    const date = new Date().toISOString().split('T')[0];
    const sanitizedTitle = summary.toLowerCase()
        .replace(/[^a-z0-9\s]/g, '')
        .split(/\s+/)
        .slice(0, 2)
        .join('-');
    const filename = `${date}-${sanitizedTitle || 'document'}.md`;
    const filePath = path.join(cwd, filename);
    fs.writeFileSync(filePath, content);
    return filename;
}

export default function(pi: ExtensionAPI) {
    const handleCommand = async (type: "bug" | "ticket", args: string, ctx: ExtensionContext) => {
        const sections = type === "bug" ? BUG_SECTIONS : TICKET_SECTIONS;
        const templateFile = type === "bug" ? "golden-bug.md" : "golden-ticket.md";
        const templatePath = path.join("/Users/mike/.dotfiles/nvim/.config/nvim/prompts", templateFile);
        const template = fs.readFileSync(templatePath, "utf-8");

        let markdownContent = "";
        let summary = "";

        if (args && args.trim().length > 0) {
            // LLM generation
            markdownContent = await ctx.ui.custom<string>((tui, theme, _kb, done) => {
                const loader = new BorderedLoader(tui, theme, `Generating Golden ${type}...`);
                loader.onAbort = () => done("");
                generateWithLLM(ctx, args, template).then(done).catch(err => {
                    ctx.ui.notify(err.message, "error");
                    done("");
                });
                return loader;
            }) || "";
            if (!markdownContent) return;
            // Extract summary from markdown if possible
            const match = markdownContent.match(/#+\s*(?:Summary|Title):?\s*(.*)/i) || markdownContent.match(/1\.\s+\*\*Summary\*\*:\s*(.*)/i);
            summary = match ? match[1].trim() : args.split(' ').slice(0, 2).join(' ');
        } else {
            // Wizard
            const results = await ctx.ui.custom<Record<string, string> | null>((tui, _theme, _kb, done) => {
                return new WizardComponent(sections, tui, done);
            });
            if (!results) return;

            const wizardPrompt = `Please expand on these notes for a ${type === "bug" ? "bug report" : "ticket"} and provide a high-quality, professional document:\n\n` +
                Object.entries(results)
                    .filter(([_, value]) => value.trim().length > 0)
                    .map(([id, value]) => {
                        const section = sections.find(s => s.id === id);
                        return `${section ? section.question : id}: ${value}`;
                    })
                    .join("\n");

            markdownContent = await ctx.ui.custom<string>((tui, theme, _kb, done) => {
                const loader = new BorderedLoader(tui, theme, `Expanding Golden ${type}...`);
                loader.onAbort = () => done("");
                generateWithLLM(ctx, wizardPrompt, template).then(content => {
                    // Strip anything before the first markdown header or horizontal rule if present
                    const lines = content.split('\n');
                    let firstHeaderIndex = lines.findIndex(l => l.startsWith('#') || l.startsWith('---'));
                    if (firstHeaderIndex === -1) {
                        done(content);
                        return;
                    }
                    
                    // If it starts with frontmatter (---), find the NEXT header after the frontmatter
                    if (lines[firstHeaderIndex].startsWith('---')) {
                        const nextIndex = lines.slice(firstHeaderIndex + 1).findIndex(l => l.startsWith('---'));
                        if (nextIndex !== -1) {
                            const postFrontMatter = lines.slice(firstHeaderIndex + nextIndex + 2);
                            const actualContentIndex = postFrontMatter.findIndex(l => l.trim().startsWith('#'));
                            if (actualContentIndex !== -1) {
                                done(postFrontMatter.slice(actualContentIndex).join('\n').trim());
                                return;
                            }
                        }
                    }

                    done(lines.slice(firstHeaderIndex).join('\n').trim());
                }).catch(err => {
                    ctx.ui.notify(err.message, "error");
                    done("");
                });
                return loader;
            }) || "";

            if (!markdownContent) return;

            // Extract summary from expanded content
            const match = markdownContent.match(/#+\s*(?:Summary|Title):?\s*(.*)/i) ||
                         markdownContent.match(/1\.\s+\*\*Summary\*\*:\s*(.*)/i) ||
                         markdownContent.match(/^\s*(?:Summary|Title):?\s*(.*)/im);
            summary = match ? match[1].trim() : results.summary;
        }

        const filename = saveMarkdown(summary, markdownContent, ctx.cwd);
        ctx.ui.notify(`Saved to ${filename}`, "success");
    };

    pi.registerCommand("bug", {
        description: "Generate a Golden Bug Report",
        handler: (args, ctx) => handleCommand("bug", args, ctx),
    });

    pi.registerCommand("ticket", {
        description: "Generate a Golden Ticket",
        handler: (args, ctx) => handleCommand("ticket", args, ctx),
    });
}
