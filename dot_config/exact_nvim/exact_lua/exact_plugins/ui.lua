local prompt = "#2d3149"

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local tokyonight = require("tokyonight")
      tokyonight.setup({
        style = "moon",
        sidebars = {
          "qf",
          "terminal",
          "startuptime",
          "undotree",
          "NvimTree",
          "toggleterm"
        },
        on_highlights = function(hl, c)
          hl.CursorLineNr = { fg = c.orange, bold = true }

          -- Telescope highlights
          hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
          hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopePromptNormal = { bg = prompt }
          hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
          hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
          hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
          hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }

          -- Noise highlights
          hl.NoiceCmdlinePopup = { bg = prompt }
          hl.NoiceCmdlineIcon = { fg = c.purple }
          hl.NoicePopupmenu = { bg = c.bg_dark }

          -- Code Action Lightbulb
          hl.LightBulbVirtualText = { fg = c.fg_dark }

          -- LSP Diagnostic
          hl.LspFloatWinNormal = { bg = prompt }

          -- Notify
          hl.NotifyERRORBody = { bg = c.bg_dark }
          hl.NotifyWARNBody = { bg = c.bg_dark }
          hl.NotifyINFOBody = { bg = c.bg_dark }
          hl.NotifyDEBUGBody = { bg = c.bg_dark }
          hl.NotifyTRACEBody = { bg = c.bg_dark }
          hl.NotifyERRORBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.NotifyWARNBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.NotifyINFOBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.NotifyDEBUGBorder = { bg = c.bg_dark, fg = c.bg_dark }
          hl.NotifyTRACEBorder = { bg = c.bg_dark, fg = c.bg_dark }
        end,
      })
      tokyonight.load()
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    config = function()
      local scrollbar = require("scrollbar")
      local colors = require("tokyonight.colors").setup()
      scrollbar.setup({
        handle = { color = colors.bg_highlight },
        excluded_filetypes = { "prompt", "TelescopePrompt", "notify", "NvimTree" },
        marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
        },
      })
    end,
  }, {
  "NvChad/nvim-colorizer.lua",
  event = "BufReadPre",
  config = {
    filetypes = { "*", "!lazy" },
    buftype = { "*", "!prompt", "!nofile" },
    user_default_options = {
      RGB = true,       -- #RGB hex codes
      RRGGBB = true,    -- #RRGGBB hex codes
      names = false,    -- "Name" codes like Blue
      RRGGBBAA = true,  -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = true,    -- CSS rgb() and rgba() functions
      hsl_fn = true,    -- CSS hsl() and hsla() functions
      css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true,    -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Available modes: foreground, background
      -- Available modes for `mode`: foreground, background,  virtualtext
      mode = "background", -- Set the display mode.
      virtualtext = "■",
    },
  },
},
  {
    'akinsho/bufferline.nvim',
    version = "3.*",
    event = "BufAdd",
    config = {
      options = {
        mode = "tabs",
        separator_style = "thick",
        buffer_close_icon = "✕",
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' }
        },
        diagnostics = "nvim_lsp",
        offsets = {
          {
            filetype = "NvimTree",
            text = "File browser",
            text_align = "left",
            separator = true
          },
          {
            filetype = "undotree",
            text = "Undo Tree",
            text_align = "left",
            separator = true
          }
        }
      }
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      { "MunifTanjim/nui.nvim", lazy = true },
    },
    opts = {
      presets = {
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = false,
      },
      cmdline = {
        format = {
          cmdline = { icon = "❯" },
          search_down = { icon = " " },
          search_up = { icon = " " },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "❔" },
          IncRename = {
            pattern = "^:%s*IncRename%s+",
            icon = " ",
            conceal = true,
          },
        }
      },
      popupmenu = {
        enabled = true,
        kind_icons = false,
        backend = "nui"
      },
      lsp = {
        progress = {
          enabled = true
        },
        hover = {
          silent = true,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        popup = {
          position = {
            row = "100%",
          },
          size = {
            height = "auto",
            width = "99%",
          },
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
        },
        cmdline_popup = {
          position = {
            row = "100%",
          },
          size = {
            height = "auto",
            width = "99%",
          },
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          filter_options = {},
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = -1
          },
          size = {
            height = "auto",
            width = "100%"
          },
          border = {
            style = "none",
            padding = { 2, 2 },
          },
          filter_options = {},
        },
        hover = {
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          position = { row = 2, col = 1 }
        }
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            any = {
              { find = "written" },
              { find = "bytes" },
              { find = "fewer lines" },
              { find = "more lines" },
              { find = "changed" },
              { find = "unchanged" },
              { find = "saved" },
              { find = "buffers deleted" }
            }
          },
          opts = { skip = true },
        },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    lazy = true,
    event = "VeryLazy",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      render = "compact"
    },
    init = function()
      vim.notify = require("notify")
    end,
  }
}
