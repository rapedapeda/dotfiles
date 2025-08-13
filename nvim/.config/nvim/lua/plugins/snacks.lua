return{
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    lazygit = { enabled = true },
  },
  keys = {
    {
      "<leader>gg",
      function()
        require("snacks.lazygit").open()
      end,
      desc = "Toggle Lazygit",
    },
  },
}
