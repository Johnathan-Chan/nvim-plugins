return {
  {
    "Kurama622/llm.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "Exafunction/codeium.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    lazy = false,
    config = function()
      local tools = require("llm.tools")
      require("llm").setup({
        -- [[ deepseek ]]
        url = "https://openrouter.ai/api/v1/chat/completions",
        model = "deepseek/deepseek-chat-v3-0324", -- "moonshot-v1-8k", "moonshot-v1-32k", "moonshot-v1-128k"
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
          Completion = {
            handler = tools.completion_handler,
            opts = {
              -------------------------------------------------
              ---                   ollama
              -------------------------------------------------
              -- url = "http://localhost:11434/v1/completions",
              -- model = "qwen2.5-coder:1.5b",
              -- api_type = "ollama",
              -- ------------------- end ollama ------------------

              -------------------------------------------------
              ---                  deepseek
              -------------------------------------------------
              url = "https://openrouter.ai/api/v1/beta/completions",
              model = "deepseek/deepseek-chat-v3-0324",
              api_type = "openai",
              fetch_key = function()
                return vim.env.LLM_KEY
              end,
              ---------------- end deepseek -----------------

              -------------------------------------------------
              ---                 siliconflow
              -------------------------------------------------
              -- url = "https://api.siliconflow.cn/v1/completions",
              -- model = "Qwen/Qwen2.5-Coder-7B-Instruct",
              -- api_type = "openai",
              -- fetch_key = function()
              --   return "your api key"
              -- end,
              ------------------ end siliconflow -----------------

              -------------------------------------------------
              ---                  codeium
              ---    dependency: "Exafunction/codeium.nvim"
              -------------------------------------------------
              -- api_type = "codeium",
              ------------------ end codeium ------------------

              n_completions = 3,
              context_window = 512,
              max_tokens = 256,

              -- A mapping of filetype to true or false, to enable completion.
              filetypes = { sh = false },

              -- Whether to enable completion of not for filetypes not specifically listed above.
              default_filetype_enabled = true,

              auto_trigger = true,

              -- just trigger by { "@", ".", "(", "[", ":", " " } for `style = "nvim-cmp"`
              only_trigger_by_keywords = true,

              style = "blink.cmp", -- nvim-cmp or blink.cmp

              timeout = 10, -- max request time

              -- only send the request every x milliseconds, use 0 to disable throttle.
              throttle = 1000,
              -- debounce the request in x milliseconds, set to 0 to disable debounce
              debounce = 400,

              --------------------------------
              ---   just for virtual_text
              --------------------------------
              keymap = {
                virtual_text = {
                  accept = {
                    mode = "i",
                    keys = "<A-a>",
                  },
                  next = {
                    mode = "i",
                    keys = "<A-n>",
                  },
                  prev = {
                    mode = "i",
                    keys = "<A-p>",
                  },
                  toggle = {
                    mode = "n",
                    keys = "<leader>cp",
                  },
                },
              },
            },
          },
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
          AttachToChat = {
            handler = tools.attach_to_chat_handler,
            opts = {
              is_codeblock = true,
              inline_assistant = true,
              language = "Chinese",
              -- display diff
              display = {
                mapping = {
                  mode = "n",
                  keys = { "d" },
                },
                action = nil,
              },
              -- accept diff
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                action = nil,
              },
              -- reject diff
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                action = nil,
              },
              -- close diff
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                action = nil,
              },
            },
          },
          Ask = {
            handler = tools.disposable_ask_handler,
            opts = {
              position = {
                row = 2,
                col = 0,
              },
              title = " Ask ",
              inline_assistant = true,
              language = "Chinese",

              -- [optinal] set your llm model
              url = "https://openrouter.ai/api/v1/chat/completions",
              model = "deepseek/deepseek-chat-v3-0324",
              api_type = "openai",
              fetch_key = function()
                return vim.env.LLM_KEY
              end,

              -- display diff
              display = {
                mapping = {
                  mode = "n",
                  keys = { "d" },
                },
                action = nil,
              },
              -- accept diff
              accept = {
                mapping = {
                  mode = "n",
                  keys = { "Y", "y" },
                },
                action = nil,
              },
              -- reject diff
              reject = {
                mapping = {
                  mode = "n",
                  keys = { "N", "n" },
                },
                action = nil,
              },
              -- close diff
              close = {
                mapping = {
                  mode = "n",
                  keys = { "<esc>" },
                },
                action = nil,
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
      {
        "<leader>paca",
        mode = "v",
        "<cmd>LLMAppHandler Ask<cr>",
        desc = "ask code",
      },
      {
        "<leader>pacA",
        mode = "v",
        "<cmd>LLMAppHandler AttachToChat<cr>",
        desc = "AttachToChat",
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
