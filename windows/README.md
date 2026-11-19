# Windows (work laptop): komorebi + whkd

i3-style tiling on Windows with [komorebi](https://github.com/LGUG2Z/komorebi)
(v0.1.41), hotkeys via [whkd](https://github.com/LGUG2Z/whkd) and
focus-follows-mouse via [masir](https://github.com/LGUG2Z/masir).
Not a stow package: Windows can't read the configs from the WSL filesystem
at boot, so `sync.sh` copies them into `%USERPROFILE%`.

| Repo file                      | Windows location                          |
|--------------------------------|-------------------------------------------|
| `komorebi.json`                | `%USERPROFILE%\komorebi.json`             |
| `.config/whkdrc`               | `%USERPROFILE%\.config\whkdrc`            |
| `.config/komorebi-startup.ps1` | `%USERPROFILE%\.config\komorebi-startup.ps1` |

```sh
./sync.sh install   # repo -> Windows
./sync.sh pull      # Windows -> repo (after editing there)
./sync.sh diff
```

## Setup on a new machine

```powershell
winget install LGUG2Z.komorebi LGUG2Z.whkd LGUG2Z.masir
komorebic fetch-asc   # downloads applications.json (app-specific rules)
```

Then `./sync.sh install` from WSL and create the startup shortcut:

```powershell
$s = (New-Object -ComObject WScript.Shell).CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\komorebi.lnk")
$s.TargetPath = "powershell.exe"
$s.Arguments  = "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$env:USERPROFILE\.config\komorebi-startup.ps1`""
$s.WindowStyle = 7; $s.Save()
```

## Layout

- Workspaces `1`–`5`, all `VerticalStack` (master left, rest stacked right).
- `1`: Outlook (`olk.exe`) + Teams (`ms-teams.exe`) via `initial_workspace_rules`,
  Alacritty launched there at startup.
- `2`: Firefox launched there at startup. No rule, so `alt+w` opens Firefox
  on whatever workspace is focused.
- `3`–`5`: spare.
- Outlook pop-out mails float: any `olk.exe` window whose title does *not*
  start with a main-window name (`E-mail`, `Postvak IN`, `Agenda`, ...).
  The main window and pop-outs are otherwise identical (same class/style).
- Theme: Catppuccin Latte borders (lavender focused, overlay0 unfocused),
  unfocused windows slightly transparent (alpha 230), padding 4px.
- komorebi-bar is not used.

## Gotchas

- **Bitwarden can't be managed**: it hardens its process so other programs
  can't read its exe path, and komorebi skips the window. Set Bitwarden to
  "start to tray" / "close to tray" instead.
- Elevated (admin) windows can't be tiled either.
- `komorebic reload-configuration` does not change the layout of running
  workspaces; use `komorebic workspace-layout <mon> <ws> vertical-stack`
  or restart (`komorebic stop --whkd; komorebic start --whkd`).
- komorebi requires a commercial license for use at work.

## Keys (mod = alt)

`alt+enter` alacritty · `alt+w` firefox · `alt+e` explorer · `alt+q` close ·
`alt+hjkl`/arrows focus · `alt+shift+hjkl`/arrows move ·
`alt+shift+enter` promote to master · `alt+1..5` workspace ·
`alt+shift+1..5` send window to workspace · `alt+f` monocle ·
`alt+shift+space` float · `alt+s` cycle layout · `alt+=`/`alt+-` resize ·
`alt+shift+c` reload komorebi · `alt+o` reload whkd
