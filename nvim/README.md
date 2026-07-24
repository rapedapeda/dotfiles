# Neovim config

Leader key is `<Space>`. Plugins are managed with
[lazy.nvim](https://github.com/folke/lazy.nvim).

## Structure

- `init.lua` → loads `lua/user/init.lua`, which loads (in order):
  - `keymaps.lua` — all custom keymaps
  - `lazy.lua` — bootstraps lazy.nvim and loads every file in `lua/plugins/`
  - `set.lua` — plain `vim.opt` settings (line numbers, tabs, clipboard, ...)
  - `autocmds.lua` — misc autocommands (yank highlight, restore cursor position,
    auto-create dirs on save, close help/quickfix with `q`, ...)
- `lua/user/org_sort.lua` — helper used by `<leader>os` to sort org-mode tasks
  by status (NEXT > TODO > DONE > CLOSED).
- `lua/plugins/*.lua` — one file per plugin, see below.

## Plugins (`lua/plugins/`)

| File | Plugin | What it's for |
|---|---|---|
| `colorscheme.lua` | catppuccin/nvim | Theme (latte flavour). |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting/parsing. |
| `lsp.lua` | nvim-lspconfig + mason | LSP servers. `lua_ls` and `pyright` configured explicitly; any other Mason-installed server is enabled automatically. Keymaps: `K` hover, `gd`/`gD`/`gi`/`go`/`gs` go-to-definition/declaration/implementation/type/signature, `<F2>` rename, `<F3>` format, `<F4>` code action, `<leader>sd` diagnostics. |
| `blink.lua` | blink.cmp | Autocompletion (LSP, path, snippets, buffer). |
| `telescope.lua` / `fzf.lua` | telescope.nvim / fzf-lua | Fuzzy finders. Telescope keymaps: `<leader>ff` files, `<leader>fg` grep, `<leader>fb` buffers, `<leader>fr` recent files, `<leader>fs`/`<leader>fS` LSP symbols, `<leader>fd` diagnostics. |
| `neotree.lua` | neo-tree.nvim | File explorer sidebar. |
| `bufferline.lua` | bufferline.nvim | Tabs-style buffer line at the top. |
| `bufremove.lua` | mini.bufremove | Close a buffer without closing its window/split: `<leader>bd` (`<leader>bD` force). |
| `gitsigns.lua` | gitsigns.nvim | Git gutter signs + hunk actions: `]c`/`[c` next/prev change, `<leader>hs`/`<leader>hr` stage/reset hunk (also visual mode), `<leader>hS`/`<leader>hR` stage/reset buffer, `<leader>hp` preview hunk, `<leader>hb` blame line, `<leader>hd`/`<leader>hD` diff against index/last commit, `<leader>tb`/`<leader>tD` toggle inline blame/deleted-lines. |
| `snacks.lua` | snacks.nvim | `<leader>gg` opens lazygit in a float, `<C-\>` toggles a floating terminal. |
| `harpoon.lua` | harpoon | Quick-jump list between frequently used files (default harpoon keymaps, not remapped here). |
| `whichkey.lua` | which-key.nvim | Shows available keymaps for the current prefix; `<leader>?` shows buffer-local ones. |
| `tmux-navigator.lua` | vim-tmux-navigator | See below. |
| `orgmode.lua` / `org-bullets.lua` / `headlines.lua` | orgmode + friends | Task/notes management (`~/notes/**/*.org`). Capture templates and custom agenda view for daily TODOs (`<leader>r` refile, `<leader>fh` search headings, `<leader>li` insert link, `<leader>of` toggle checkbox). |

## Tmux integration

`<C-h/j/k/l>` (in `lua/user/keymaps.lua`) navigate Neovim splits via
vim-tmux-navigator instead of the plain `<C-w>h/j/k/l`. When Neovim runs
inside a tmux pane, the same keys keep working seamlessly across the pane
boundary — no need to know whether you're moving between a Neovim split or
a tmux pane. Outside tmux it just behaves like plain window navigation.
See the [tmux README](../tmux/README.md) for the other half of this setup.
