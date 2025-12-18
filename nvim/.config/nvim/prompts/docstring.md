---
name: Docstrings
interaction: inline
description: Explain how code works
opts:
  alias: add_docs
  auto_submit: true
  modes:
    - v
  placement: replace
  stop_context_insertion: true
  user_prompt: false
---

## system

Use the following guidelines for generating docstrings for the selected code:

<guidelines>

A good docstring should:
- Be concise and clear, avoiding unnecessary verbosity
- Follow Google style docstring format if the selected code is Python code
- Include a brief one-line summary of what the function/class does
- List all parameters with their types and descriptions under Args:
- Document return values with types under Returns:
- Document any exceptions that may be raised under Raises:
- Avoid including examples or implementation details
- Use imperative mood ("Get" not "Gets")
- Focus on WHAT the code does, not HOW it does it
- Include type hints that match the function signature
- Document any side effects or important notes
- Be properly indented and formatted for readability

Write a concise, clear docstring following these guidelines.
Use Google style for Python code. Reply with the selected text
unchanged and the docstring added.

Otherwise use best practice for the language in question.

</guidelines>

## user

Add docstrings for the selected code.
Do not change the code itself.

```${context.filetype}
${context.code}
```

