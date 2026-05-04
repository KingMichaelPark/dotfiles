---
name: answer
description: Extracts questions from the assistant's last message and presents them for answering using an interactive UI.
license: MIT
metadata:
  author: mike
  version: "1.0"
---

Extract questions from the last assistant message and present them to the user for answering. Use this skill when the user indicates they want to answer questions you've previously asked, or when you detect multiple unanswered questions in your last turn.

**Workflow**

1. **Extract Questions**
   Analyze the previous assistant message (your own last response) and extract all questions that require user input.
   For each question, identify:
   - The question text
   - Any relevant context from the message that helps answer it

   **Extraction Rules:**
   - Extract all questions that require user input
   - Keep questions in the order they appeared
   - Be concise with question text
   - Include context only when it provides essential information for answering

2. **Present Questions**
   Use the `ask_user` tool to present the questions to the user.
   - For each extracted question, create a question object in `ask_user`.
   - Use `type: "text"` or `type: "choice"` as appropriate.
   - Use the `header` field for a short label.
   - Use the `question` field for the full question.

3. **Process Answers**
   Once the user provides answers, format them as a clear response and acknowledge them.
   
   **Response Format:**
   "I answered your questions in the following way:
   
   Q: <Question 1>
   A: <Answer 1>
   
   Q: <Question 2>
   A: <Answer 2>
   ..."

4. **Trigger Next Steps**
   Based on the answers provided, proceed with the task or provide the next set of instructions.

**Guardrails**
- Only extract questions that actually need answering for the task to proceed.
- If no questions are found in the last message, inform the user: "No questions found to answer."
- If the last assistant message was incomplete or errored, do not attempt to extract questions.
