local diagnostics = require'lsp-status.diagnostics'
local colors = require'moonlight.colors'

local function getDiagnostics(severity)
  return function ()
    local bufh = vim.api.nvim_get_current_buf()
    local count = diagnostics(bufh)[severity]
    if count > 0 then
      return count..''
    else
      return '0'
    end
  end
end

require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
    theme = 'moonlight',
    globalstatus = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {{require'lsp_spinner'.status, color = { fg = colors.accent }}},
    lualine_y = {
      {getDiagnostics('errors'), color = { bg = colors.red, fg = colors.bg }},
      {getDiagnostics('warnings'), color = { bg = colors.yellow, fg = colors.bg }},
      {getDiagnostics('info'), color = { bg = colors.purple, fg = colors.bg }},
      {getDiagnostics('hints'), color = { bg = colors.blue, fg = colors.bg }},
    },
    lualine_z = {'LineNoIndicator'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'LineNoIndicator'},
    lualine_y = {},
    lualine_z = {}
  },
}
