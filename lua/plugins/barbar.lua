return {
  -- 插件名称
  "romgrk/barbar.nvim",
  -- 插件依赖
  dependencies = {
    "lewis6991/gitsigns.nvim", -- 可选：用于 git 状态
    "nvim-tree/nvim-web-devicons", -- 可选：用于文件图标
  },
  -- 插件版本
  version = "^1.0.0", -- 可选：仅在 1.x 版本更新时更新
  -- 初始化配置
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  -- 插件选项
  config = function()
        local barbar = require("barbar")
	barbar.setup({
            clickable = true,
	    tabpages = false,
	    insert_at_end = true,
	    icons = {
                button = "x",
		buffer_index = true,
		filetype = {enabled = true},
		visible = {modified = {buffer_number = false}},
		gitsigns = {
                    added = {enabled = true, icon = "+"},
		    changed = {enabled = true, icon = "~"},
		    deleted = {enabled = true, icon = "-"}
		}
	    }
	})
        end
}
