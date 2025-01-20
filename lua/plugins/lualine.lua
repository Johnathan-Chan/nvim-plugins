return {
  -- 插件名称
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim"},
  -- 插件配置
  config = function()
    -- 获取默认配置
    -- local lualine_config = require("lualine").get_config()
    -- 加载默认配置
    require("lualine").setup({options = {theme = "catppuccin"}})
  end
}
