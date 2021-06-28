require'lspsaga'.init_lsp_saga {
  -- use_saga_diagnostic_sign = true
  -- error_sign = '',
  -- warn_sign = '',
  -- hint_sign = '',
  -- infor_sign = '',
  dianostic_header_icon = ' ⊘  ',
  code_action_icon = '',
  finder_definition_icon = '⍟  ',
  finder_reference_icon = '⍟  ',
  definition_preview_icon = '⊕  ',
  rename_prompt_prefix = '❯',
}

local opts = { silent = true }
vim.api.nvim_set_keymap('n', '<Leader>R', '<cmd>Lspsaga rename<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>c', '<cmd>Lspsaga code_action<CR>', opts)
