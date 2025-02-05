return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  -- optional: provides snippets for the snippet source
  dependencies = {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
        { path = "luvit-meta/library", words = { "vim%.uv" } }
      }
    }
  },

  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- On musl libc based systems you need to add this flag
  -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    signature = { enabled = true },
    sources = {
      default = { 'lsp' },
      per_filetype = {
        lua = { 'lazydev', 'lsp' },
      },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
      },
    },
    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= 'cmdline' and not require('blink.cmp').snippet_active({ direction = 1 })
          end,
          auto_insert = function(ctx) return ctx.mode ~= 'cmdline' end
        }
      },
      menu = {
        scrollbar = false,
        draw = {
          padding = 5,
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = false,
      },
    },
    keymap = {
      preset = "enter"
    },
  },
  opts_extend = { "sources.default" }
}
