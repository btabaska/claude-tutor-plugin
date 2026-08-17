#!/bin/sh
# principal-track SessionStart hook: print the one-line statusline if it exists.
# Data dir arrives as $1 (substituted in hooks.json); env var is the fallback.
data_dir="${1:-${CLAUDE_PLUGIN_DATA:-}}"
[ -n "$data_dir" ] || exit 0
[ -f "$data_dir/statusline.txt" ] || exit 0
cat "$data_dir/statusline.txt"
exit 0
