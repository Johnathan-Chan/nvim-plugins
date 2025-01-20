return {
  -- 插件名称
  "navarasu/onedark.nvim",
  -- 插件配置
  config = function()
    require("onedark").setup({
      style = "deep",
    })
    require("onedark").load()
  end,
  -- 设置 colorscheme
  -- {
  --  "LazyVim/LazyVim",
  --  opts = {
  --    colorscheme = "onedark",
  --  },
  -- },
}
