<div align="center">

# 🔨 skillsmith

**Self-improving [Claude Code](https://claude.com/claude-code) skills.**

Correct Claude once. Run `/skillsmith`. The lesson is folded back into the skill's `SKILL.md` — after you approve the diff. Your skills get sharper every time you use them.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Plugin](https://img.shields.io/badge/Claude%20Code-plugin-d97757.svg)](https://claude.com/claude-code)
![Version](https://img.shields.io/badge/version-0.1.0-blue.svg)

</div>

<p align="center">
  <img src="assets/demo.gif" alt="skillsmith demo: correct Claude, run /skillsmith, approve the diff" width="720">
</p>

---

## The problem

You invoke a skill. Claude gets it 90% right. You correct it — "no, always use `pnpm` here", "stop adding comments", "match the existing test style". It fixes it. **Then you close the session and the lesson is gone.** Next time, same correction.

The fix you keep meaning to do: ask Claude to update the `SKILL.md` so it remembers. skillsmith automates that last step — safely.

Next time you use the skill, it already knows.

## Why it's safe

- **🔍 Diff-approve, never silent.** Every edit is shown as a diff and written only on your explicit **yes**.
- **🪶 Keeps skills lean.** Tightens an existing rule instead of piling on new ones, and flags contradictions instead of stacking them.
- **↩️ Reversible.** Keep your skills in git — every update is one revertible commit.
- **🎯 No noise.** One-off task details are ignored. Only durable, reusable lessons change the skill.

## Install

Run each command **separately** (one per prompt — don't paste both at once):

1. Add the marketplace:

   ```
   /plugin marketplace add https://github.com/HarshMehta112/skillsmith.git
   ```

2. Install the plugin:

   ```
   /plugin install skillsmith@skillsmith
   ```

3. Reload so it's available:

   ```
   /reload-plugins
   ```

## How it works

Run `/skillsmith` at the end of any task. It:

1. **Finds every skill** used in the current session.
2. **Scans for corrections** — rejected output, added constraints, repeated instructions — and attributes each to the skill it belongs to.
3. **Proposes a concise `SKILL.md` diff per skill** — preferring to tighten existing rules, flagging any contradictions.
4. **Asks yes/no for each skill** — and edits that file only on **yes**.

Used several skills in one session? Each gets its own diff and its own approval. No corrections found? It says so and changes nothing.

## Components

| File | Role |
|------|------|
| `commands/skillsmith.md` | the `/skillsmith` reflection command |

That's the whole plugin — one command, no background hooks, no state on disk. Easy to read, easy to trust.

## Roadmap

- [ ] **Automatic reflection across sessions** — stage a finished session on exit, offer to review it at the next session start.
- [ ] Target a specific skill by name.
- [ ] Batch-reflect across several past sessions.

Contributions welcome — open an issue or PR.

## License

[MIT](LICENSE)
