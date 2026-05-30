---
name: skillsmith
description: Review the current session for corrections the user made, then propose and (on yes) apply updates to each relevant SKILL.md.
---

You are running the skillsmith reflection loop for the **current session**.

A session may use more than one skill. Reflect on **each skill separately** — never merge lessons across skills.

## Steps

1. **List every skill used.** Scan the whole session for skills invoked — `Skill` tool calls, `/<name>` commands, or a `SKILL.md` that was loaded. Build the set of distinct skills. If none were used, say so and stop.

2. **Detect corrections, attributed per skill.** Scan the conversation for places where the user:
   - corrected, rejected, or re-did something a skill produced,
   - added a constraint or preference a skill missed,
   - repeated an instruction a skill should have known.

   Attribute each lesson to the **specific skill** that was active when it happened. If a correction can't be tied to a skill with confidence, drop it. Ignore one-off task details — only durable, reusable lessons count.

3. **Drop skills with nothing durable.** Keep only skills that have at least one real correction. If no skill has any, report "No skill changes needed" and stop. Never fabricate edits.

4. **Process each remaining skill in turn.** For each skill, one at a time:

   a. **Propose its diff.** Show the exact `<skill>/SKILL.md` edits (old → new) as concrete rules. Keep additions short; prefer tightening an existing rule over adding new ones. Flag any rule that contradicts an existing one.

   b. **Ask:** "Apply these changes to `<skill>/SKILL.md`? (yes/no)".

   c. **On yes:** apply the edits with the Edit tool. **On no:** skip this skill, change nothing.

   Move to the next skill regardless of yes/no. One skill's answer never affects another's.

5. **Summarize.** After all skills are processed, report which `SKILL.md` files were updated and which were skipped.

## Rules

- Never write to any SKILL.md without an explicit yes for that skill.
- Keep each skill lean — if a new rule contradicts an existing one, flag the conflict and ask which wins before editing.
- Each skill gets its own diff and its own yes/no — never bundle multiple skills into one approval.
- If the user's skills are in git, remind them to commit so the changes are reversible.
