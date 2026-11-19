#!/usr/bin/env bash
# Sync the Windows-side configs (komorebi, whkd, startup script) between
# this repo and %USERPROFILE%. Run from WSL.
#
#   ./sync.sh install   repo    -> Windows   (then alt+shift+c / alt+o to reload)
#   ./sync.sh pull      Windows -> repo      (after editing on the Windows side)
#   ./sync.sh diff      show differences
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
win_home="$(wslpath "$(cmd.exe /c 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')")"

files=(
  komorebi.json
  .config/whkdrc
  .config/komorebi-startup.ps1
)

case "${1:-}" in
  install)
    for f in "${files[@]}"; do
      mkdir -p "$(dirname "$win_home/$f")"
      cp -v "$here/$f" "$win_home/$f"
    done
    ;;
  pull)
    for f in "${files[@]}"; do
      cp -v "$win_home/$f" "$here/$f"
    done
    ;;
  diff)
    for f in "${files[@]}"; do
      diff -u "$here/$f" "$win_home/$f" || true
    done
    ;;
  *)
    echo "usage: $0 install|pull|diff" >&2
    exit 1
    ;;
esac
