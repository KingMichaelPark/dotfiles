---
name: golden-bug
description: Generates a high-quality, standardized bug report using a guided wizard or LLM expansion.
license: MIT
metadata:
  author: mike
  version: "1.0"
---

Generate a professional "Golden Bug Report". This skill helps capture all necessary information to make a bug actionable.

**Workflow**

1. **Information Gathering**
   If the user provides a brief description, you can use the LLM to expand it. Otherwise, use the `ask_user` tool to collect the following fields:

   | Field | Description |
   |-------|-------------|
   | **Summary** | Concise description (e.g., [Component] - [Error] when [Action]) |
   | **Environment** | OS, Browser, Version, Environment (Prod/Staging) |
   | **Description** | High-level overview of the issue |
   | **Steps to Reproduce** | Numbered list of steps |
   | **Expected Result** | What should have happened? |
   | **Actual Result** | What actually happened? |
   | **Technical Analysis** | Code references, potential root cause |
   | **Visuals/Logs** | Placeholders for screenshots, stack traces |
   | **Severity/Priority** | Suggested level based on impact |

2. **Drafting the Report**
   Use the gathered information to generate a markdown document following this structure:

   ```markdown
   # Bug Report: <Summary>

   ## Environment
   <Environment>

   ## Description
   <Description>

   ## Steps to Reproduce
   1. <Step 1>
   2. <Step 2>
   ...

   ## Expected Result
   <Expected Result>

   ## Actual Result
   <Actual Result>

   ## Technical Analysis
   <Technical Analysis>

   ## Visuals / Logs
   <Visuals/Logs>

   ## Severity / Priority
   <Severity/Priority>
   ```

3. **Saving the Report**
   - Generate a filename: `YYYY-MM-DD-<sanitized-summary>.md`
   - Save the file to the current directory using `write_file`.

4. **Confirmation**
   Inform the user that the bug report has been saved and provide the filename.

**Guardrails**
- Ensure all critical fields (Summary, Steps, Expected, Actual) are filled.
- Keep the tone professional and technical.
- If using LLM expansion, ensure it stays grounded in the provided context.
