return {
  'ten3roberts/qf.nvim',
  dependencies = { 'romainl/vim-qf' },
  ft = "qf",
  keys = {
    { ']q', '<Plug>(qf_qf_next)', mode = 'n', desc = '' },
    { '[q', '<Plug>(qf_qf_previous)', mode = 'n', desc = '' },
    { '<Leader><CR>', function() require 'qf'.toggle('c') end, mode = 'n', desc = '', silent = true }
  },
  config = true
}
