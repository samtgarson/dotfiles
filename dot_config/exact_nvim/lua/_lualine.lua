require('lualine').setup {
  options = {
    section_separators = '',
    component_separators = '',
    icons_enabled = false,
    theme = 'moonlight'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      'diagnostics',
      sources = {'nvim_lsp'},
      sections = {'error', 'warn'}
    },
    lualine_y = {'progress'},
    lualine_z = {'LineNoIndicator'}
  },
}
