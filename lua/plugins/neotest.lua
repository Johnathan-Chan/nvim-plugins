return {
  "nvim-neotest/neotest",
  optional = true,
  opts = function(_, opts)
    opts = opts or {}
    opts.consumers = opts.consumers or {}
    opts.consumers.overseer = require("neotest.consumers.overseer")
  end,
}
