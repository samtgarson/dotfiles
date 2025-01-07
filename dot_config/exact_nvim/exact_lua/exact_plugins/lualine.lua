return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/tokyonight.nvim",
    "nvim-lua/lsp-status.nvim"
  },
  config = function()
    local diagnostics = require 'lsp-status.diagnostics'
    local colors = require("tokyonight.colors").setup()
    local git_blame = require('gitblame')
    local theme = require 'lualine.themes._tokyonight'.get("moon")

    local mode_color = {
      n = colors.blue,
      i = colors.green,
      v = colors.magenta,
      r = colors.red,
      default = colors.yellow
    }

    local fg = colors.fg_dark
    local bg = colors.bg

    local function getCount(severity)
      local bufh = vim.api.nvim_get_current_buf()
      return diagnostics(bufh)[severity]
    end

    local function getDiagnostics(severity, color)
      return {
        function() return getCount(severity) .. '' end,
        color = function()
          if getCount(severity) > 0 then
            return { fg = color }
          else
            return { fg = colors.fg_gutter }
          end
        end
      }
    end

    theme.normal.a.bg = bg
    theme.normal.b.bg = bg
    theme.normal.c.bg = bg

    theme.normal.a.fg = fg
    theme.normal.b.fg = fg
    theme.normal.c.fg = fg

    require('lualine').setup {
      options = {
        section_separators = { left = ' | ', right = ' | ' },
        component_separators = '',
        icons_enabled = false,
        theme = theme,
        globalstatus = true
      },
      extensions = { 'neo-tree' },
      sections = {
        lualine_a = {
          { function() return '→' end, color = { fg = colors.fg_gutter, bg = bg } },
          {
            function() return string.lower(require('lualine.utils.mode').get_mode()) end,
            color = function()
              local key = string.lower(string.sub(vim.fn.mode(), 1, 1))
              return { fg = mode_color[key] or colors.blue, bg = bg }
            end
          }
        },
        lualine_b = { {
          'branch',
          color = { fg = fg, bg = bg },
          icons_enabled = true,
          icon = ''
        }
        },
        lualine_c = {
          {
            function() return string.sub(git_blame.get_current_blame_text(), 1, 100) end,
            cond = git_blame.is_blame_text_available,
            color = { fg = colors.comment },
            on_click = function() git_blame.open_commit_url() end
          },
        },
        lualine_x = {},
        lualine_y = {
          getDiagnostics('errors', colors.error),
          getDiagnostics('warnings', colors.warning),
          getDiagnostics('info', colors.info),
          getDiagnostics('hints', colors.hint),
        },
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { 'LineNoIndicator' },
        lualine_y = {},
        lualine_z = {}
      },
    }
  end
}
