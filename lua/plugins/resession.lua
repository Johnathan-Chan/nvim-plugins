return {
  "stevearc/resession.nvim",
  lazy = false,
  config = function()
    local resession = require("resession")
    resession.setup({
      extensions = {
        overseer = {
          -- customize here
        },
      },
    })
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only load the session if nvim was started with no args and without reading from stdin
        if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
          -- Save these to a different directory, so our manual sessions don't get polluted
          resession.load(vim.fn.getcwd())
          vim.cmd("Neotree")
        end
        -- vim.cmd("silent! %bwipeout!")
      end,
      nested = true,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        -- Only load the session if nvim was started with no args and without reading from stdin
        if vim.fn.argc(-1) == 0 and not vim.g.using_stdin then
          resession.save(vim.fn.getcwd())
        end
      end,
    })
  end,
  keys = {
    -- 可选手动保存/加载会话的快捷键
    {
      "<leader>pss",
      function()
        require("resession").save()
      end,
      desc = "Save Session",
    },
    {
      "<leader>psl",
      function()
        require("resession").load()
      end,
      desc = "Load Session",
    },
    {
      "<leader>psd",
      function()
        require("resession").delete()
      end,
      desc = "Delete Session",
    },
  },
}
