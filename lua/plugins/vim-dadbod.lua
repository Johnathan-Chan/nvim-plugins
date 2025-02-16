-- 数据库可视化插件
return {
  { "tpope/vim-dadbod", envent = "VeryLazy" },
  {
    "kristijanhusak/vim-dadbod-ui",
    envent = "VeryLazy",
    keys = {
      { "<leader>pd", mode = "n", "<cmd>:DBUI<cr>", desc = "db ui" },
    },
  },
  { "kristijanhusak/vim-dadbod-completion", envent = "VeryLazy" },
}
