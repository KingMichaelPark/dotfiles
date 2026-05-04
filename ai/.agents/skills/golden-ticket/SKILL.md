---
name: golden-ticket
description: Generates a high-quality, standardized engineering ticket (user story) using a guided wizard or LLM expansion.
license: MIT
metadata:
  author: mike
  version: "1.0"
---

Generate a professional "Golden Ticket". This skill helps capture technical requirements and acceptance criteria for a new feature or task.

**Workflow**

1. **Information Gathering**
   If the user provides a brief description, you can use the LLM to expand it. Otherwise, use the `ask_user` tool to collect the following fields:

   | Field | Description |
   |-------|-------------|
   | **Summary/Title** | Clear, concise, prefixed with component |
   | **User Story** | As a [role], I want to [action], so that [value] |
   | **Context/Background** | Why are we doing this? |
   | **Technical Requirements** | Specific implementation details |
   | **Acceptance Criteria (AC)** | Checklist format (Gherkin preferred) |
   | **Definition of Done (DoD)** | Standard engineering requirements |
   | **Security & Performance** | Specific considerations |

2. **Drafting the Ticket**
   Use the gathered information to generate a markdown document following this structure:

   ```markdown
   # Ticket: <Summary/Title>

   ## User Story
   <User Story>

   ## Context / Background
   <Context/Background>

   ## Technical Requirements
   <Technical Requirements>

   ## Acceptance Criteria
   <Acceptance Criteria>

   ## Definition of Done
   <Definition of Done>

   ## Security & Performance Considerations
   <Security & Performance>
   ```

3. **Saving the Ticket**
   - Generate a filename: `YYYY-MM-DD-<sanitized-summary>.md`
   - Save the file to the current directory using `write_file`.

4. **Confirmation**
   Inform the user that the ticket has been saved and provide the filename.

**Guardrails**
- Ensure the User Story follows the standard format.
- Ensure Acceptance Criteria are clear and testable.
- Keep the tone professional and technical.
- If using LLM expansion, ensure it stays grounded in the provided context.
