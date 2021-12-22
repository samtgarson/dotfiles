runtime! vimscript/**/*.vim

lua << EOF
CONFIG_PATH = vim.fn.stdpath('config')
DATA_PATH = vim.fn.stdpath('data')
CACHE_PATH = vim.fn.stdpath('cache')

require('_plugins')
require('overmind')
EOF
