. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# npm utils
alias npms='bat package.json | jq .scripts -r'

# 1password utils
1p () {
  local cmd="${1:-pass}"
  case $cmd in
    login)
      eval $(op signin $2)
      ;;
    pass)
      1p_get | xargs -I % op get item "%" | jq -r '.details.fields[] |select(.designation=="password").value'
      ;;
    totp)
      1p_get | xargs -I % op get totp "%"
      ;;
    doc)
      1p_get | xargs -I % op get document "%"
      ;;
    *)
      echo "$fg[red]Command $fg_bold[white]$cmd$fg_no_bold[red] not recognised$fg_no_bold[default]"
      ;;
  esac
}

1p_get () {
  op list items | jq -r '.[].overview.title' | fzf
}

