return {
  'ten3roberts/qf.nvim',
  dependencies = { 'romainl/vim-qf' },
  ft = "qf",
  keys = {
    { ']q',           '<Plug>(qf_qf_next)',                    mode = 'n', desc = 'Next quickfix item' },
    { '[q',           '<Plug>(qf_qf_previous)',                mode = 'n', desc = 'Previous quickfix item' },
    { '<Leader><CR>', function() require 'qf'.toggle('c') end, mode = 'n', desc = 'Toggle quickfix window', silent = true }
  },
  config = true
}
