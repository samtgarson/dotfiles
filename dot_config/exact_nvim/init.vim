runtime! vimscript/**/*.vim

lua << EOF
CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

require('_telescope')
require('_compe')
require('_trouble')
require('_lsp')
require('_lualine')
require('_treesitter')
require('_tabline')
require('_gitsigns')
EOF
