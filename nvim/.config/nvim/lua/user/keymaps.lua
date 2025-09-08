vim.g.mapleader = ' '
local map = vim.keymap.set


-- Move between windows
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- Buffer closing through mini-bufremove plugin

-- Org mode sorting
map('n', '<leader>os', function()
    require('user.org_sort').sort_current_buffer()
end, { desc = 'Sort org tasks' })

