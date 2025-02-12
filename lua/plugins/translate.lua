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

      -- 自定义快捷键
      vim.keymap.set("n", "<leader>pt", ":Translate ZH<CR>", { desc = "Translate English to Chinese" })
      vim.keymap.set("v", "<leader>pt", ":Translate ZH<CR>", { desc = "Translate selected text to Chinese" })
    end,
  },
}
