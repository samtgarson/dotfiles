
require('plugins/_compe')
require('plugins/_copilot')
require('plugins/_gitsigns')
require('plugins/_lsp')
require('plugins/_lualine')
require('plugins/_nvim_tree')
require('plugins/_tabline')
require('plugins/_telescope')
require('plugins/_treesitter')
require('plugins/_whichkey')

-- Plugins with no config
require("stabilize").setup()
require('renamer').setup { title = '' }
