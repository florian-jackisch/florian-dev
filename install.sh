#!/usr/bin/env bash
set -euo pipefail

copilot_home="${COPILOT_HOME:-$HOME/.copilot}"
instructions_file="$copilot_home/copilot-instructions.md"
start_marker="<!-- flow-preferences -->"
end_marker="<!-- /flow-preferences -->"

managed_block=$(
  cat <<'EOF'
<!-- flow-preferences -->
## Flow Preferences

- Never add `Co-authored-by` trailers for Copilot.
- Keep commit messages brief: one summary line under 72 characters, plus one optional explanatory paragraph when useful.
- Treat `obra/superpowers` as opt-in. Do not auto-invoke Superpowers skills unless I explicitly request them.
- New pull requests and merge requests should start as draft. Never undraft them or assign reviewers automatically.
<!-- /flow-preferences -->
EOF
)

mkdir -p "$copilot_home"

tmp_file="$(mktemp)"
cleanup() {
  rm -f "$tmp_file"
}
trap cleanup EXIT

if [[ -f "$instructions_file" ]]; then
  awk -v start="$start_marker" -v end="$end_marker" '
    $0 == start { skip = 1; next }
    $0 == end { skip = 0; next }
    !skip { print }
    END { if (skip) exit 1 }
  ' "$instructions_file" >"$tmp_file" || {
    echo "Error: found $start_marker without matching $end_marker in $instructions_file" >&2
    echo "Please fix the file manually and re-run." >&2
    exit 1
  }
else
  : >"$tmp_file"
fi

if [[ -s "$tmp_file" ]]; then
  trimmed_file="$(mktemp)"
  awk '
    { lines[NR] = $0 }
    END {
      last = NR
      while (last > 0 && lines[last] == "") {
        last--
      }
      for (i = 1; i <= last; i++) {
        print lines[i]
      }
      if (last > 0) {
        print ""
      }
    }
  ' "$tmp_file" >"$trimmed_file"
  mv "$trimmed_file" "$tmp_file"
fi

printf '%s\n' "$managed_block" >>"$tmp_file"
mv "$tmp_file" "$instructions_file"
trap - EXIT

echo "Updated $instructions_file"
