#!/usr/bin/env bash
# skillsmith SessionStart hook.
# If the last session in THIS project was staged, inject context telling
# Claude to ask the user yes/no and (on yes) run the skill-reflector agent.
# Toggle off:  export SKILLSMITH_AUTO=0
set -euo pipefail

[ "${SKILLSMITH_AUTO:-1}" = "0" ] && exit 0

store_dir="$HOME/.claude/skillsmith"
pending="$store_dir/pending.tsv"
[ -f "$pending" ] || exit 0

input="$(cat 2>/dev/null || true)"
cwd="$(printf '%s' "$input" | python3 -c '
import sys, json
try:
    print(json.load(sys.stdin).get("cwd",""))
except Exception:
    print("")
' 2>/dev/null || echo "")"
[ -z "$cwd" ] && cwd="$PWD"

# transcripts staged for this project
matches="$(grep -F "$(printf '%s\t' "$cwd")" "$pending" 2>/dev/null | cut -f2 || true)"
[ -z "$matches" ] && exit 0

# keep entries for other projects; drop this project's
remaining="$(grep -vF "$(printf '%s\t' "$cwd")" "$pending" 2>/dev/null || true)"
if [ -n "$remaining" ]; then
  printf '%s\n' "$remaining" > "$pending"
else
  rm -f "$pending"
fi

last="$(printf '%s\n' "$matches" | tail -n1)"

ctx="skillsmith: the previous session in this project ended and was staged for skill review. Transcript: ${last}. At a natural point, ask the user exactly: \"Found possible skill improvements from the last session. Review and apply? (yes/no)\". If yes, launch the skill-reflector agent with that transcript path, show the proposed SKILL.md diff, and apply only after the user confirms. If no, do nothing."

python3 -c '
import json, sys
print(json.dumps({"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":sys.argv[1]}}))
' "$ctx"
exit 0
