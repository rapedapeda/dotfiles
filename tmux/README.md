# Tmux config

Plugins are vendored directly into `.config/tmux/plugins/` (plain files
committed to this repo, not a submodule or TPM install) and loaded with
`run ~/.config/tmux/plugins/<name>/...`.

## Theme (catppuccin)

`.config/tmux/plugins/catppuccin/` — sets the `latte` flavour and a
`rounded` window style, then builds `status-right` out of catppuccin's
status modules: current application, cpu, ram, session name, uptime,
battery. The `cpu`/`battery` modules need `tmux-cpu`/`tmux-battery` to
actually produce numbers — those `run` lines are commented out below the
status-right block until (if ever) those plugins get added.

`@catppuccin_reset "true"` forces the plugin to recompute all of its
colors from the current flavour on every reload. Without it, color
options are only set the *first* time they're seen (so you can override
individual colors) — which means switching `@catppuccin_flavor` and
reloading silently keeps the old colors around from whatever flavour was
active the first time this tmux server ever loaded the plugin. Keeping
`@catppuccin_reset` on avoids ever hitting that again.

## Pane navigation: Ctrl-h/j/k/l

No prefix needed — `<C-h/j/k/l>` (and `<C-\>` for "last pane") switch
panes directly. An `is_vim` check detects whether the active pane is
running vim/nvim; if so, the keys are forwarded to it instead of
switching panes. This pairs with the
[vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
plugin on the Neovim side (see the [nvim README](../nvim/README.md)) so
the same keys move seamlessly between tmux panes and Neovim splits,
whichever you're currently in. Without Neovim open, it's just plain pane
switching. The `copy-mode-vi` bindings repeat the same keys so pane
switching also works while in copy mode.

## Other options

- `mouse on` — click to switch panes/windows, drag to resize/scroll.
- `default-terminal "tmux-256color"` — proper color support inside tmux.
