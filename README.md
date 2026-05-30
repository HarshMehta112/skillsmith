# skillsmith

Self-improving [Claude Code](https://claude.com/claude-code) skills. When you correct Claude during a session, skillsmith folds those corrections back into the skill's `SKILL.md` — after you approve a diff. Your skills get smarter the more you use them.

## Why

The usual loop: invoke a skill → correct Claude a few times → manually ask it to update `SKILL.md`. skillsmith automates that last step, safely:

- **Diff-approve, never silent.** Every change is shown as a diff and applied only on your **yes**.
- **Lean skills.** It tightens existing rules instead of piling on new ones, and flags contradictions.
- **Reversible.** Keep your skills in git — every update is one revertible commit.

## Install

```
/plugin marketplace add <your-github-username>/skillsmith
/plugin install skillsmith@skillsmith
```

Replace `<your-github-username>` with your GitHub user (or org). No marketplace submission required — your repo *is* the marketplace.

## How it works

**1. Manual (in-session) — `/skillsmith`**
Run it any time at the end of a task. It reviews the current session, proposes `SKILL.md` edits for any corrections you made, and asks yes/no.

**2. Automatic (across sessions)**
- When a session **ends**, skillsmith silently stages it for review.
- At the **start** of your next session *in the same project*, Claude asks:
  > Found possible skill improvements from the last session. Review and apply? (yes/no)
- **yes** → it runs the `skill-reflector` agent, shows the diff, applies on your confirm.

### Why the prompt is at next start, not at exit

A `SessionEnd` hook **cannot prompt you** — the session is already closing, Claude is gone. So the only way to get a real yes/no around exit is to stage on exit and ask on the next start. That is what skillsmith does.

## Toggle the automatic flow

On by default. To disable the auto stage/ask (keep only `/skillsmith`):

```bash
export SKILLSMITH_AUTO=0
```

## Components

| File | Role |
|------|------|
| `commands/skillsmith.md` | `/skillsmith` in-session reflection command |
| `agents/skill-reflector.md` | subagent that reads a transcript and proposes edits |
| `hooks/hooks.json` | `SessionEnd` stage + `SessionStart` ask |
| `scripts/*.sh` | hook logic |

## License

MIT
