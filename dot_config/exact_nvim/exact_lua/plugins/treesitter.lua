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
        'ruby',
        'scss',
        'tsx',
        'typescript',
        'scss',
        'sql',
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
    })
  end,
  { "pantharshit00/vim-prisma", ft = 'prisma' },
  { "amadeus/vim-mjml", event = 'VeryLazy' },
  {
    "Glench/Vim-Jinja2-Syntax",
    ft = { 'jinja', 'jinja2' },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.njk",
        command = "set filetype=jinja",
      })
    end
  },
}
