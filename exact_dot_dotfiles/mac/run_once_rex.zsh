#!/usr/bin/env zsh

set -eu

[[ -d "/Applications/Rex Beta.app" || -d "/Applications/Rex.app" ]] && exit 0

if [[ "$(uname -m)" != arm64 ]]; then
  echo "Rex requires Apple silicon."
  exit 1
fi

work_dir=$(mktemp -d)
trap '[[ ! -d "$work_dir/mount" ]] || hdiutil detach "$work_dir/mount" -quiet; rm -rf "$work_dir"' EXIT

curl -fsSL https://blob.superlogical.com/public/rex-app/preview-arm64/appcast.xml -o "$work_dir/appcast.xml"
download_url=$(xmllint --xpath 'string(/rss/channel/item[1]/enclosure/@url)' "$work_dir/appcast.xml")
curl -fsSL "$download_url" -o "$work_dir/rex.dmg"
hdiutil attach "$work_dir/rex.dmg" -nobrowse -readonly -mountpoint "$work_dir/mount" -quiet
ditto "$work_dir/mount/Rex Beta.app" "/Applications/Rex Beta.app"
