vim.g.mapleader = ' '
local map = vim.keymap.set


-- Terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>th", "<cmd>split | terminal<cr>", { desc = "Terminal horizontal split" })
map("n", "<leader>tv", "<cmd>vsplit | terminal<cr>", { desc = "Terminal vertical split" })

-- Move between windows (and tmux panes, via vim-tmux-navigator)
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Go to Left Window/Pane" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Go to Lower Window/Pane" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Go to Upper Window/Pane" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Go to Right Window/Pane" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Buffer closing through mini-bufremove plugin

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document Symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { desc = "Workspace Symbols" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- Org mode sorting
map('n', '<leader>os', function()
    require('user.org_sort').sort_current_buffer()
end, { desc = 'Sort org tasks' })

-- Move current project/area file into archive/
map('n', '<leader>om', function()
    require('user.org_archive').archive_current_file()
end, { desc = 'Move to archive' })

