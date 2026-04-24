return{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
    terminal = {
      enabled = true,
      win = { style = "float" },
    },
  },
  keys = {
    {
      "<leader>gg",
      function() Snacks.lazygit.open() end,
      desc = "Toggle Lazygit",
    },
    {
      "<C-\\>",
      function() Snacks.terminal.toggle() end,
      mode = { "n", "t" },
      desc = "Toggle Terminal",
    },
  },
}
