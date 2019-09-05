source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

mkdir -p ~/.rubies
RUBIES=(~/.rubies/*)

chruby ruby
