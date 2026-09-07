#!/usr/bin/env zsh
# Claude Code SessionStart/CwdChanged hook: run setup_new_worktree once per worktree.
# Reads the hook payload on stdin; falls back to $PWD when there is none.

emulate -L zsh

input=""
[[ -t 0 ]] || input="$(cat)"
if [[ "$input" =~ '"new_cwd"[[:space:]]*:[[:space:]]*"([^"]+)"' ]]; then
  dir="$match[1]"
elif [[ "$input" =~ '"cwd"[[:space:]]*:[[:space:]]*"([^"]+)"' ]]; then
  dir="$match[1]"
else
  dir="$PWD"
fi

cd "$dir" 2>/dev/null || exit 0

git_dir="$(git rev-parse --git-dir 2>/dev/null)" || exit 0
common_dir="$(git rev-parse --git-common-dir 2>/dev/null)" || exit 0
[[ "$(realpath "$git_dir")" == "$(realpath "$common_dir")" ]] && exit 0

marker="$git_dir/claude-worktree-setup-done"
[[ -e "$marker" ]] && exit 0

log="$git_dir/claude-worktree-setup.log"
source ~/.dotfiles/git/worktrees/config.zsh
if setup_new_worktree >"$log" 2>&1; then
  touch "$marker"
  echo "setup_new_worktree completed (log: $log)"
else
  echo "setup_new_worktree failed, see $log"
fi
