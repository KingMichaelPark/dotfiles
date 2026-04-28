import type {
    ExtensionAPI,
    ToolCallEvent,
    FileOperations,
} from "@mariozechner/pi-coding-agent";
import {
    isToolCallEventType,
    createEditTool,
} from "@mariozechner/pi-coding-agent";
import { readFile, writeFile, unlink } from "node:fs/promises";
import { join, resolve } from "node:path";
import { tmpdir } from "node:os";
import { randomBytes } from "node:crypto";

/**
 * Delta Confirmation Extension
 *
 * Intercepts 'write' and 'edit' tool calls to show a diff using 'delta'
 * and asks for user confirmation.
 */

let sessionConfirmed = false;

export default function(pi: ExtensionAPI) {
    pi.on("tool_call", async (event: ToolCallEvent, ctx) => {
        // Skip if already confirmed for session, or no UI available
        if (sessionConfirmed || !ctx.hasUI) return;

        let path: string | undefined;
        let newContent: string | undefined;
        let oldContent: string = "";

        if (isToolCallEventType("write", event)) {
            path = event.input.path;
            newContent = event.input.content;
        } else if (isToolCallEventType("edit", event)) {
            path = event.input.path;
            const absolutePath = resolve(ctx.cwd, path);
            try {
                oldContent = await readFile(absolutePath, "utf-8");

                // Use the actual edit tool logic to preview the change
                let previewContent = oldContent;
                const mockOps: FileOperations = {
                    readFile: async () => oldContent,
                    writeFile: async (_, content) => {
                        previewContent = content;
                    },
                    mkdir: async () => undefined,
                    access: async () => { },
                    realpath: async (p) => p,
                };
                const editTool = createEditTool(ctx.cwd, {
                    operations: mockOps,
                });
                await editTool.execute(
                    event.toolCallId,
                    event.input,
                    undefined,
                    undefined,
                    ctx,
                );
                newContent = previewContent;
            } catch (e) {
                // If edit fails, we can't show a diff, but let the tool run and fail naturally
            }
        }

        if (path && newContent !== undefined) {
            const absolutePath = resolve(ctx.cwd, path);
            if (oldContent === "") {
                try {
                    oldContent = await readFile(absolutePath, "utf-8");
                } catch (e) {
                    // New file
                    oldContent = "";
                }
            }

            const tmpDir = tmpdir();
            const id = randomBytes(8).toString("hex");
            const oldFile = join(tmpDir, `old-${id}`);
            const newFile = join(tmpDir, `new-${id}`);

            await writeFile(oldFile, oldContent);
            await writeFile(newFile, newContent);

            try {
                // Run delta to get a nice diff
                const { stdout, stderr, code } = await pi.exec("delta", [
                    oldFile,
                    newFile,
                    "--paging=never",
                    "--width",
                    "1000",
                    "--file-style=omit",
                    "--hunk-header-style=omit",
                ]);

                const diffOutput = stdout || stderr;
                if (!diffOutput.trim() && code === 0) return;

                const choices = [
                    "Yes, once",
                    "Yes, for this session",
                    "No, block",
                    "No, abandon & undo",
                ];
                const choice = await ctx.ui.select(
                    `Review changes for ${path}:\n\n${diffOutput}\n\nProceed?`,
                    choices,
                );

                if (choice === "Yes, for this session") {
                    sessionConfirmed = true;
                } else if (choice === "No, abandon & undo") {
                    const branch = ctx.sessionManager.getBranch();
                    // branch[0] is assistant message (current leaf)
                    // branch[1] is user message
                    // branch[2] is previous leaf
                    const targetId = branch[2]?.id;
                    if (targetId) {
                        ctx.sessionManager.branch(targetId);
                    } else {
                        ctx.sessionManager.resetLeaf();
                    }
                    ctx.abort?.();
                    return { block: true, reason: "Abandoned by user" };
                } else if (choice !== "Yes, once") {
                    return { block: true, reason: "Blocked by user" };
                }
            } catch (e: any) {
                ctx.ui.notify(`Delta failed: ${e.message}`, "error");
            } finally {
                await unlink(oldFile).catch(() => { });
                await unlink(newFile).catch(() => { });
            }
        }
    });

    // Reset session confirmation on new session or reload
    pi.on("session_start", () => {
        sessionConfirmed = false;
    });
}
