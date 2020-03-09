# spaceship config
RED='\033[0;31m'
GREEN='\033[1;92m'
NC='\033[0m' # No Color

export SPACESHIP_DOCKER_SHOW=false
export SPACESHIP_BATTERY_THRESHOLD=20
export SPACESHIP_KUBECONTEXT_SYMBOL='☸ '
export SPACESHIP_KUBECONTEXT_COLOR_GROUPS=(
  red 'production'
)
export SPACESHIP_KUBECONTEXT_NAMESPACE_SHOW=false
export SPACESHIP_GIT_STATUS_COLOR='yellow'
export SPACESHIP_GIT_STATUS_DELETED='×'
export SPACESHIP_RUBY_SYMBOL=' '
export SPACESHIP_GIT_SYMBOL='☰  '
export SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # SSH user section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  kubecontext   # Kubectl context section
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  line_sep      # Line break
  exit_code     # Exit code section
  char          # Prompt character
)

export SPACESHIP_RPROMPT_ORDER=(
  battery
)


