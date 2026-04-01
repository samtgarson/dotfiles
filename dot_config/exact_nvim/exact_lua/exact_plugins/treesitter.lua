return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  build = ":TSUpdate",
  event = { "VeryLazy" },
  opts = {
    ensure_installed = {
      'bash',
      'css',
      'gitignore',
      'hcl',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'regex',
      'ruby',
      'scss',
      'scss',
      'sql',
      'tsx',
      'typescript',
      'yaml'
    },
    auto_install = true,
    highlight = {
      enable = true
    },
    indent = {
      enable = true
    },
  },
  { "pantharshit00/vim-prisma", ft = 'prisma' },
  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "xml" },
    opts = {},
  }
}
