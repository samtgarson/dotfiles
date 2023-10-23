return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/lsp-status.nvim"
  },
  config = function()
    local diagnostics = require 'lsp-status.diagnostics'
    local colors = require("tokyonight.colors").setup()
    local git_blame = require('gitblame')

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
            return { fg = colors.comment }
          end
        end
      }
    end

    require('lualine').setup {
      options = {
        section_separators = '',
        component_separators = '',
        icons_enabled = false,
        theme = 'tokyonight',
        globalstatus = true
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          'filename',
          {
            function() return string.sub(git_blame.get_current_blame_text(), 1, 100) end,
            cond = git_blame.is_blame_text_available,
            color = { fg = colors.comment },
            on_click = function() git_blame.open_file_url() end
          },
        },
        lualine_y = {
          getDiagnostics('errors', colors.error),
          getDiagnostics('warnings', colors.warning),
          getDiagnostics('info', colors.info),
          getDiagnostics('hints', colors.hint),
        }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'LineNoIndicator' },
        lualine_y = {},
        lualine_z = {}
      },
    }
  end
}
