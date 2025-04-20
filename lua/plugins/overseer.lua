return {
  "stevearc/overseer.nvim",
  opts = {},
  keys = {
    { "<leader>por", mode = { "n", "v" }, ":OverseerRun<CR>", desc = "overseer run" },
    { "<leader>pos", mode = { "n", "v" }, ":OverseerSaveBundle<CR>", desc = "overseer save bundle" },
    { "<leader>pol", mode = { "n", "v" }, ":OverseerLoadBundle<CR>", desc = "overseer load bundle" },
    { "<leader>pod", mode = { "n", "v" }, ":OverseerDeleteBundle<CR>", desc = "overseer delete bundle" },
    { "<leader>pot", mode = { "n", "v" }, ":OverseerToggle<CR>", desc = "overseer toggle" },
  },
}
