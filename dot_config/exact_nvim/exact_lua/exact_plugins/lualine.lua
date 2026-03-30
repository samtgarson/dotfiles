return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "folke/tokyonight.nvim",
    "rebelot/kanagawa.nvim",
  },
  config = function()
    local is_conductor = require("config.theme").is_conductor
    local colors, theme
    if is_conductor then
      colors = require("kanagawa.colors").setup({ theme = "dragon" }).palette
      theme = require("lualine.themes.kanagawa")
    else
      colors = require("tokyonight.colors").setup()
      theme = require 'lualine.themes._tokyonight'.get("moon")
    end
    local git_blame = require('gitblame')
    local overseer = require('overseer')
    local overseer_constants = require('overseer.constants')

    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local mode_color = {
      n = colors.blue,
      i = colors.green,
      v = colors.magenta,
      r = colors.red,
      default = colors.yellow
    }

    local fg = colors.fg_dark
    local bg = colors.bg

    local severity_map = {
      errors = vim.diagnostic.severity.ERROR,
      warnings = vim.diagnostic.severity.WARN,
      info = vim.diagnostic.severity.INFO,
      hints = vim.diagnostic.severity.HINT,
    }

    local function getCount(severity)
      local counts = vim.diagnostic.count(0)
      return counts[severity_map[severity]] or 0
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

    ---@return overseer.Task | nil
    local function getRunningTasks()
      return overseer.list_tasks({
        status = { overseer_constants.STATUS.PENDING, overseer_constants.STATUS.RUNNING }
      })[1]
    end

    local function getSpinner()
      local hrtime = vim.uv.hrtime
      return spinner[math.floor(hrtime() / (1e6 * 80)) % #spinner + 1]
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
          icon = ''
        }
        },
        lualine_c = {
          {
            function() return getSpinner() .. ' Running: ' .. getRunningTasks().name end,
            color = { fg = colors.comment },
            on_click = function() overseer.toggle() end,
          },
          {
            function() return string.sub(git_blame.get_current_blame_text(), 1, 100) end,
            cond = function()
              if getRunningTasks() ~= nil then return false end
              return git_blame.is_blame_text_available()
            end,
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
