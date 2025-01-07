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
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          "lazy.nvim",
          { path = "luvit-meta/library", words = { "vim%.uv" } }
        }
      }
    },
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
        { name = "lazydev" },
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

-- return {
--   'saghen/blink.cmp',
--   lazy = false, -- lazy loading handled internally
--   -- optional: provides snippets for the snippet source
--   -- dependencies = 'rafamadriz/friendly-snippets',
--
--   -- use a release tag to download pre-built binaries
--   version = 'v0.*',
--   -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
--   -- build = 'cargo build --release',
--   -- On musl libc based systems you need to add this flag
--   -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
--
--   opts = {
--     highlight = {
--       -- sets the fallback highlight groups to nvim-cmp's highlight groups
--       -- useful for when your theme doesn't support blink.cmp
--       -- will be removed in a future release, assuming themes add support
--       use_nvim_cmp_as_default = true,
--     },
--     -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--     -- adjusts spacing to ensure icons are aligned
--     nerd_font_variant = 'normal',
--     -- experimental auto-brackets support
--     -- accept = { auto_brackets = { enabled = true } }
--     -- experimental signature help support
--     trigger = { signature_help = { enabled = true } },
--     windows = {
--       documentation = {
--         auto_show = true
--       }
--     },
--     keymap = {
--       show = '<C-space>',
--       hide = '<C-e>',
--       accept = '<CR>',
--       select_prev = { '<Up>', '<C-p>' },
--       select_next = { '<Down>', '<C-n>' },
--
--       show_documentation = '<C-space>',
--       hide_documentation = '<C-space>',
--       scroll_documentation_up = '<C-b>',
--       scroll_documentation_down = '<C-f>',
--
--       snippet_forward = '<Tab>',
--       snippet_backward = '<S-Tab>',
--     },
--   }
-- }
