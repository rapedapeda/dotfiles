vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.clipboard = "unnamedplus" -- Enables the system wide clipboard
vim.opt.swapfile = false -- No locking and swap problems

-- Split new windows right or below
vim.opt.splitbelow = true
vim.opt.splitright = true

