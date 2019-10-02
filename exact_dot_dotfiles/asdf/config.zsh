. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# npm utils
alias npms='bat package.json | jq .scripts -r'

# 1password utils
function 1p () { eval $(op signin $1) }
function pass () { op get item "$1" |jq -r '.details.fields[] |select(.designation=="password").value' }
