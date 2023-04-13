return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        'bash',
        'css',
        'gitignore',
        'html',
        'javascript',
        'json',
        'lua',
        'markdown',
        'markdown_inline',
        'ruby',
        'scss',
        'tsx',
        'typescript',
        'scss',
        'sql',
        'yaml'
      },
      auto_install = true,
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
    })
  end,
  { "pantharshit00/vim-prisma", ft = 'prisma' },
  { "amadeus/vim-mjml",         event = 'VeryLazy' },
}
