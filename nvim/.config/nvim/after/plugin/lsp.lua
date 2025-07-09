-- lsp-config.lua

-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
--local cmp = require("cmp")

local blnk = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require('lspconfig')
lspconfig['lua_ls'].setup({ capabilities = blnk })

lsp.preset('recommended')

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()


lsp.setup()
--cmp.setup({
--    preselect = cmp.PreselectMode.None,
--    mapping = {
--    ["<CR>"] = cmp.config.disable,
--    ["<C-p>"] = cmp.mapping.select_prev_item(),
--    ["<C-n>"] = cmp.mapping.select_next_item(),
--    ["<C-e>"] = cmp.mapping.abort(),
--    ["<C-y>"] = cmp.mapping.confirm(),
--    --['<C-c>'] = cmp.mapping.complete(),
--    },
--    sources = cmp.config.sources({
--    { name = 'nvim_lsp' },
--    { name = 'buffer' },
--    { name = 'path' },
--    { name = 'luasnip' },
--    })
--})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', '<leader>sd', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    --vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('i', '<C-y>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})
