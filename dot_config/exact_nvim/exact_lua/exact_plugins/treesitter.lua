return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-refactor",
  },
  build = ":TSUpdate",
  event = { "VeryLazy" },
  opts = {
    ensure_installed = {
      'bash',
      'css',
      'dap_repl',
      'gitignore',
      'hcl',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
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
    refactor = {
      highlight_definitions = { enable = true },
      highlight_current_scope = { enable = true }
    }
  },
  { "pantharshit00/vim-prisma", ft = 'prisma' },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    opts = {},
  }
}
