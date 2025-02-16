-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- -- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

--barbar.lua Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
--map("n", "<leader>dT", function()
--  -- 获取当前光标下的 Test 方法名
--  local test_name = vim.fn.expand("<cword>")
--  -- 设置 DAP 配置
--  require("dap").run({
--    type = "go",
--    name = "Debug Test",
--    request = "launch",
--    mode = "test",
--    program = "${fileDirname}",
--    args = { "-test.v", "-test.run", "^" .. test_name .. "$" },
--  })
--end, { desc = "Debug Test under cursor" })

vim.keymap.set({ "n", "v" }, "<leader>p", "", { desc = "custom plugin" })
