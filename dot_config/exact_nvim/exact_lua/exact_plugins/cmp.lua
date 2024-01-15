return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  version = false,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',
    -- 'ray-x/cmp-treesitter',
  },
  config = function()
    vim.o.completeopt = "menu,menuone,noselect"

    -- Setup nvim-cmp.
    local cmp = require("cmp")

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "emoji" },
      }),
      experimental = {
        ghost_text = {
          hl_group = "LspCodeLens",
        },
      },
      window = {
        completion = {
          -- side_padding = 2,
          border = "solid",
        }
      }
    })
  end
}
