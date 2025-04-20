return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>pm", mode = { "n", "v" }, ":MarkdownPreviewToggle<CR>", desc = "markdown preview" },
    -- { "<leader>pmp", mode = { "n", "v" }, ":MarkdownPreview<CR>", desc = "markdown preview" },
  },
}
