import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

/**
 * Extension to ensure confirmation for potentially sensitive tool calls.
 * Auto-allows safe commands (ls, find, cat, rg, fd) and read-only tools.
 */
export default function(pi: ExtensionAPI) {
    // Built-in tools that are considered safe (read-only)
    const allowedTools = new Set(["read", "ls", "find", "grep"]);

    // Bash commands that are considered safe
    const allowedBaseCommands = new Set(["ls", "find", "cat", "rg", "fd"]);

    // Track allowed tool calls by their serialized input to support "Allow Always" for the session
    const allowedAlways = new Set<string>();

    /** Naive check for bash command safety */
    function isBashCommandSafe(command: string): boolean {
        // Split by common shell separators: |, &, ;
        const parts = command.split(/[|&;]+/);
        for (let part of parts) {
            part = part.trim();
            if (!part) continue;

            // Skip environment variable assignments (e.g., VAR=val cmd)
            while (
                part.includes("=") &&
                !part.startsWith("/") &&
                part.split(/\s+/)[0].includes("=")
            ) {
                const words = part.split(/\s+/);
                if (words.length <= 1) {
                    part = "";
                    break;
                }
                part = words.slice(1).join(" ").trim();
            }

            if (!part) continue;

            const firstWord = part.split(/\s+/)[0];
            // Strip path if it's an absolute path (e.g., /bin/ls -> ls)
            const baseName = firstWord.split("/").pop() || "";

            if (!allowedBaseCommands.has(baseName)) {
                return false;
            }
        }
        return true;
    }

    pi.on("tool_call", async (event, ctx) => {
        const { toolName, input } = event;
        // Create a unique key for this tool call and its arguments
        const callKey = `${toolName}:${JSON.stringify(input)}`;

        // 1. Check if this exact call was already "Allowed Always" in this session
        if (allowedAlways.has(callKey)) {
            return;
        }

        // 2. Check if it's an auto-allowed built-in read-only tool
        if (allowedTools.has(toolName)) {
            return;
        }

        // 3. Check if it's a bash command composed only of allowed tools
        if (
            toolName === "bash" &&
            typeof input.command === "string" &&
            isBashCommandSafe(input.command)
        ) {
            return;
        }

        // 4. If it's not pre-approved, ask for confirmation if UI is available
        if (!ctx.hasUI) {
            // In non-interactive modes (like -p), we must block if we can't ask
            return {
                block: true,
                reason: `Confirmation required for ${toolName}, but no UI available.`,
            };
        }

        const description =
            toolName === "bash"
                ? `run the command:\n\n  ${input.command}`
                : `use the tool '${toolName}' with arguments:\n\n${JSON.stringify(input, null, 2)}`;

        const choice = await ctx.ui.select(
            `The agent wants to ${description}\n\nDo you want to allow it?`,
            ["Allow Once", "Allow Always", "Deny"],
        );

        if (choice === "Allow Once") {
            return; // Proceed this time
        } else if (choice === "Allow Always") {
            allowedAlways.add(callKey);
            return; // Proceed and skip future checks for this exact call
        } else {
            return { block: true, reason: "Execution denied by user." };
        }
    });
}
