#!/usr/bin/env bash
# skillsmith SessionEnd hook.
# Cannot prompt the user (session is ending) — so it STAGES the session
# for review on next start in the same project.
# Toggle off:  export SKILLSMITH_AUTO=0
set -euo pipefail

[ "${SKILLSMITH_AUTO:-1}" = "0" ] && exit 0

input="$(cat)"

read -r transcript cwd <<EOF
$(printf '%s' "$input" | python3 -c '
import sys, json
try:
    d = json.load(sys.stdin)
except Exception:
    print(" "); sys.exit(0)
print(d.get("transcript_path","") or "-", d.get("cwd","") or "-")
' 2>/dev/null || echo "- -")
EOF

[ "${transcript:-}" = "-" ] && exit 0
[ -z "${transcript:-}" ] && exit 0

store_dir="$HOME/.claude/skillsmith"
mkdir -p "$store_dir"
# one line per staged session:  cwd<TAB>transcript<TAB>epoch
printf '%s\t%s\t%s\n' "${cwd:-$PWD}" "$transcript" "$(date +%s)" >> "$store_dir/pending.tsv"
exit 0
