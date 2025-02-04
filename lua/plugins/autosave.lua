return {
  "Pocco81/auto-save.nvim",
  event = "BufReadPost",
  config = function()
    local last_undo_time = 0

    -- 旧版本替代方案：通过 TextChanged 事件间接检测
    vim.api.nvim_create_autocmd("TextChanged", {
      pattern = "*",
      callback = function()
        -- 当连续操作间隔 < 0.3 秒时，认为是 Undo/Redo
        local now = vim.loop.hrtime()
        if (now - last_undo_time) / 1e9 < 0.3 then
          last_undo_time = now
          return
        end
        last_undo_time = now
      end,
    })

    require("auto-save").setup({
      enabled = true,
      events = { "InsertLeave", "TextChanged", "CursorHold" },
      condition = function(buf)
        local now = vim.loop.hrtime()
        return (now - last_undo_time) / 1e9 >= 0.3
      end,
    })
  end,
}
