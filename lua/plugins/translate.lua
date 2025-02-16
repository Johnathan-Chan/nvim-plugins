return {
  {
    "uga-rosa/translate.nvim",
    config = function()
      require("translate").setup({
        default = {
          command = "google",
        },
        output = {
          float = true,
        },
      })
    end,

    keys = {
      { "<leader>pt", mode = { "n", "v" }, ":Translate ZH<CR>", desc = "Translate text to ZH" },
    },
  },
}
