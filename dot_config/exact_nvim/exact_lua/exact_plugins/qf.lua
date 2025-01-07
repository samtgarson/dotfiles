return {
  {
    'ten3roberts/qf.nvim',
    ft = "qf",
    keys = {
      { ']q',           function() require 'qf'.below('c') end,  mode = 'n', desc = 'Next quickfix item' },
      { '[q',           function() require 'qf'.above('c') end,  mode = 'n', desc = 'Previous quickfix item' },
      { '<Leader><CR>', function() require 'qf'.toggle('c') end, mode = 'n', desc = 'Toggle quickfix window', silent = true }
    },
    config = true
  },
  { "yorickpeterse/nvim-pqf", ft = "qf" },
}
