return {
  "lmburns/lf.nvim",
  cmd = "Lf",
  dependencies = {
    "akinsho/toggleterm.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    border = "rounded",
    escape_quit = true,
    winblend = 0,
  },
  keys = {
    { "<leader>lf", "<cmd>Lf<cr>", desc = "Lf" },
  },
}
