return {
  -- 插件名称
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "catppuccin/nvim" },
  opts = function(_, opts)
    local icon = LazyVim.config.icons.kinds.TabNine
    table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("cmp_tabnine", icon))
  end,
  -- 插件配置
  config = function()
    -- 获取默认配置
    -- local lualine_config = require("lualine").get_config()
    -- 加载默认配置
    require("lualine").setup({
      options = { theme = "catppuccin" },
      disoections = {
        lualine_x = { "overseer" },
      },
    })
  end,
}
