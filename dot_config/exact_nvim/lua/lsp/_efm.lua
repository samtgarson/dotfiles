
local M = {}

-- prettier
local prettier
if vim.fn.glob("node_modules/.bin/prettier") then
  prettier = {
    formatCommand = "./node_modules/.bin/prettier --stdin-filepath ${INPUT}",
    formatStdin = true
  }
end

-- eslint
local eslint = {
  lintCommand = "./node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "./node_modules/.bin/eslint --fix --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

-- rubocop
local rubocop = {
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion -s ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = ""
}

function M.setup(base)
  require'lspconfig'.efm.setup(vim.tbl_extend(
    'keep',
    {
      init_options = {documentFormatting = true, codeAction = true},
      filetypes = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "markdown",
        "ruby",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml"
      },
      settings = {
        rootMarkers = {".git/"},
        languages = {
          html = {prettier},
          css = {prettier},
          scss = {prettier},
          yaml = {prettier},
          javascriptreact = {prettier, eslint},
          javascript = {prettier, eslint},
          markdown = {prettier},
          typescriptreact = {prettier, eslint},
          typescript = {prettier, eslint},
          ruby = {rubocop}
        }
      }
    },
    base
  ))
end

-- Autoformat on save
vim.api.nvim_command('augroup AutoFormatOnSave')
vim.api.nvim_command('autocmd!')
local jsExtensions = { 'js', 'ts', 'jsx', 'tsx' }
local extensions = vim.list_extend({ 'css', 'scss', 'rb', 'md', 'json' }, jsExtensions)

for _, ext in pairs(jsExtensions) do
  vim.api.nvim_command('autocmd BufWritePre *.'..ext..' OrganizeImports')
end

for _, ext in pairs(extensions) do
  vim.api.nvim_command('autocmd BufWritePre *.'..ext..' lua vim.lsp.buf.formatting_seq_sync(nil, 1000)')
end
vim.api.nvim_command('augroup END')


return M
