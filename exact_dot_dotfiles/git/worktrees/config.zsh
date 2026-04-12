# get the source (main working tree) directory, or fail if not in a worktree
_worktree_source_dir() {
  if ! git rev-parse --is-inside-work-tree &>/dev/null; then
    echo "Not inside a git repository" >&2
    return 1
  fi

  local git_common_dir="$(git rev-parse --git-common-dir 2>/dev/null)"
  local git_dir="$(git rev-parse --git-dir 2>/dev/null)"
  if [[ "$(realpath "$git_common_dir")" == "$(realpath "$git_dir")" ]]; then
    echo "Not a worktree (this is the main working tree)" >&2
    return 1
  fi

  dirname "$git_common_dir"
}

# copy all branch changes (committed + uncommitted) from current worktree to the main working tree
copy_changes_to_source() {
  local source_dir="$(_worktree_source_dir)" || return 1
  local worktree_dir="$(pwd)"
  local main_branch=$(git -C "$worktree_dir" symbolic-ref refs/remotes/origin/HEAD | splt 4 '/')
  local merge_base=$(git -C "$worktree_dir" merge-base "origin/$main_branch" HEAD)

  # check for uncommitted changes in source
  if ! git -C "$source_dir" diff --quiet HEAD 2>/dev/null || [[ -n "$(git -C "$source_dir" ls-files --others --exclude-standard)" ]]; then
    echo "Source directory has uncommitted changes: $source_dir"
    read -q "confirm?Reset and overwrite? [y/N] " || { echo; return 1; }
    echo
  fi

  # capture all changes since divergence from main (committed + uncommitted)
  git -C "$worktree_dir" add -A
  git -C "$worktree_dir" diff --cached --no-ext-diff "$merge_base" > /tmp/worktree-changes.patch
  git -C "$worktree_dir" reset HEAD --quiet

  # reset source to merge-base for clean apply
  git -C "$source_dir" checkout "$main_branch" --quiet
  git -C "$source_dir" reset --hard "$merge_base" --quiet
  git -C "$source_dir" clean -fd --quiet

  # apply patch
  if [[ -s /tmp/worktree-changes.patch ]]; then
    git -C "$source_dir" apply /tmp/worktree-changes.patch
    echo "Changes copied to $source_dir (reset to $(echo $merge_base | cut -c1-7))"
  else
    echo "No changes to copy"
  fi

  rm -f /tmp/worktree-changes.patch
}

# setup a new worktree with env files, mise, and dependencies
setup_new_worktree() {
  local source_dir="$(_worktree_source_dir)" || return 1

  # copy .env and mise.local.toml if they exist in source
  for f in .env mise.local.toml; do
    if [[ -f "$source_dir/$f" && ! -f "$f" ]]; then
      cp "$source_dir/$f" "$f"
      echo "Copied $f"
    fi
  done

  # run mise trust and install
  if [[ -f .mise.toml || -f mise.toml || -f mise.local.toml ]]; then
    mise trust
    mise install
  fi

  # install dependencies
  if [[ -f pnpm-lock.yaml ]]; then
    pnpm install
  elif [[ -f package-lock.json ]]; then
    npm install
  elif [[ -f yarn.lock ]]; then
    yarn install
  elif [[ -f bun.lockb || -f bun.lock ]]; then
    bun install
  fi
}
