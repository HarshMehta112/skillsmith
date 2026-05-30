---
name: skillsmith
description: Review the current session for corrections the user made, then propose and (on yes) apply updates to the relevant SKILL.md.
---

You are running the skillsmith reflection loop for the **current session**.

## Steps

1. **Find the active skill.** Look back through this session for which skill was invoked (a `Skill` tool call, a `/<name>` command, or a `SKILL.md` that was loaded). If no skill was used, say so and stop.

2. **Detect corrections.** Scan the conversation for places where the user:
   - corrected, rejected, or re-did something the skill produced,
   - added a constraint or preference the skill missed,
   - repeated an instruction the skill should have known.
   Ignore one-off task details — only durable, reusable lessons count.

3. **If no real corrections:** report "No skill changes needed" and stop. Do not invent edits.

4. **Propose a diff.** For each lesson, show the exact `SKILL.md` edit (old → new) as a concrete rule. Keep additions short; prefer editing an existing rule over piling on new ones. Show the full proposed diff.

5. **Ask the user:** "Apply these changes to `<skill>/SKILL.md`? (yes/no)".

6. **On yes:** apply the edits with the Edit tool. On no: stop, change nothing.

## Rules

- Never write to SKILL.md without an explicit yes.
- Do not let the skill bloat — if a new rule contradicts an existing one, flag the conflict and ask which wins.
- If the user's skills are in git, remind them to commit so the change is reversible.
