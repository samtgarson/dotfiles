require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'html',
    'javascript',
    'json',
    'ruby',
    'scss',
    'tsx',
    'typescript',
    'yaml'
  },
  highlight = {
    enable = true
  },
  indent = {
    enable = true
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true }
  }
}
