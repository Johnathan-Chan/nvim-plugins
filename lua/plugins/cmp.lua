return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
    "onsails/lspkind-nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = { "rafamadriz/friendly-snippets" },
      config = function()
        require("luasnip.lazy_loadoaders.from_vscode").lazy_load()
      end,
    },
    { "saaparwaiz1/cmp_luasnip", enabled = true },
  },
  config = function()
    local luasnip = require("luasnip")
    local types = require("luasnip.util.types")

    luasnip.config.setup({
      ext_opts = {
        [types.choiceNode] = {
          active = { virt_text = { { "->", "GruvboxRed" } } },
        },
        [types.insertNode] = {
          active = { virt_text = { { "->", "GruvboxBlue" } } },
        },
      },
    })

    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
      }),
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_test",
          maxwidth = 70,
          show_labelDetails = true,
        }),
      },
    })

    local lspconfig = require("lspconfig")
    -- golang lspconfig
    lspconfig["golsp"].setup({})
    -- rust lspconfig
    lspconfig["rust-analyzer"].setup({})
  end,
}
