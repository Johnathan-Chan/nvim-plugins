return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    require("overseer").enable_dap()
  end,
}
