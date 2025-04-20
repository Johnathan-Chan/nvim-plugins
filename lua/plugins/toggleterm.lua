return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    { "<C-t>", mode = { "n", "v", "i" }, ":ToggleTerm<CR>", desc = "termieterm" },
  },
}
