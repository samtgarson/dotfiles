runtime! vimscript/**/*.vim

lua << EOF
CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

require('plugins/_telescope')
require('plugins/_compe')
require('plugins/_lsp')
require('plugins/_lualine')
require('plugins/_treesitter')
require('plugins/_tabline')
require('plugins/_gitsigns')
require('plugins/_lspsaga')
require('plugins/_whichkey')
require('plugins/_nvim_tree')
require('overmind')
EOF
