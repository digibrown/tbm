#!/usr/bin/env bash
set -euo pipefail

# Mirror trevorbrownmusic.com into docs/trevorbrownmusic for GitHub Pages hosting.
TARGET_DIR=".."
#mkdir -p "$TARGET_DIR"

mirror() {
  local url=$1
  wget \
    --mirror \
    --convert-links \
    --adjust-extension \
    --page-requisites \
    --no-parent \
    --retry-connrefused \
    --waitretry=5 \
    --tries=3 \
    --directory-prefix="$TARGET_DIR" \
    "$url"
}

if ! mirror "http://trevorbrownmusic.com/"; then
  echo "Primary HTTP mirror attempt failed, trying HTTPS..." >&2
  mirror "https://trevorbrownmusic.com/"
fi
