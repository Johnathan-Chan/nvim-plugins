return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    config = function()
      local tools = require("llm.common.tools")
      require("llm").setup({
        -- [[ kimi ]]
        url = "https://api.moonshot.cn/v1/chat/completions",
        model = "moonshot-v1-8k", -- "moonshot-v1-8k", "moonshot-v1-32k", "moonshot-v1-128k"
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,

        prompt = "You are a helpful chinese assistant.",

        prefix = {
          user = { text = "😃 ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "i", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-j>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-k>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "}float" style.
          ["Session:Toggle"]    = { mode = "n", key = "<leader>pac" },
          ["Session:Close"]     = { mode = {"n", "i"}, key = {"<esc>", "q"} },
        },

        -- display diff [require by action_handler]
        display = {
          diff = {
            layout = "vertical", -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        },
        app_handler = {
          -- Your AI tools Configuration
          -- TOOL_NAME = { ... }
          WordTranslate = {
            handler = tools.flexi_handler,
            prompt = "Translate the following text to Chinese, please only return the translation",
            opts = {
              exit_on_move = true,
              enter_flexible_window = false,
            },
          },
          Translate = {
            handler = tools.qa_handler,
            opts = {
              component_width = "60%",
              component_height = "50%",
              query = {
                title = " 󰊿 Trans ",
                hl = { link = "Define" },
              },
              input_box_opts = {
                size = "15%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
              preview_box_opts = {
                size = "85%",
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                },
              },
            },
          },
          CodeExplain = {
            handler = tools.flexi_handler,
            prompt = "Explain the following code, please only return the explanation, and answer in Chinese",
            opts = {
              enter_flexible_window = true,
            },
          },
          OptimizeCode = {
            handler = tools.side_by_side_handler,
            opts = {
              left = {
                focusable = false,
              },
            },
          },
        },
      })
    end,

    keys = {
      { "<leader>pa", mode = { "n", "v" }, desc = "AI" },
      { "<leader>pas", mode = { "n", "v" }, "<cmd>LLMSessionToggle<cr>", desc = "chat session toggle" },
      { "<leader>pac", mode = { "v" }, desc = "code" },
      {
        "<leader>pacf",
        mode = "v",
        "<cmd>LLMSelectedTextHandler 请修复下面这段异常报错的代码, 并返回修复后完整的代码即可<cr>",
        desc = "fix error code",
      },
      {
        "<leader>paco",
        mode = "v",
        "<cmd>LLMAppHandler OptimizeCode<cr>",
        desc = "optimize code",
      },
      {
        "<leader>pace",
        mode = "v",
        "<cmd>LLMAppHandler CodeExplain<cr>",
        desc = "explain code",
      },
      { "<leader>pat", mode = { "n", "v" }, desc = "translate" },
      {
        "<leader>patt",
        mode = { "n", "v" },
        "<cmd>LLMAppHandler Translate<cr>",
        desc = "translate to US tool",
      },
      {
        "<leader>pats",
        mode = "v",
        "<cmd>LLMSelectedTextHandler 请将下面这段文本翻译为中文<cr>",
        desc = "translate selected text to ZH",
      },
      {
        "<leader>patw",
        mode = "v",
        "<cmd>LLMAppHandler WordTranslate<cr>",
        desc = "word translate",
      },
    },
  },
}
