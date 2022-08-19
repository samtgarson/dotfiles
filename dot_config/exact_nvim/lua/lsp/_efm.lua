
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
  formatCommand = "bundle exec rubocop -A -f quiet --stderr --force-exclusion -s ${INPUT}",
  formatStdin = true
}

function M.setup()
  return {
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
      rootMarkers = {".git/", "package.json"},
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
  }
end

-- Autoformat on save
vim.api.nvim_command('augroup AutoFormatOnSave')
vim.api.nvim_command('autocmd!')
local jsExtensions = { '*.js', '*.ts', '*.jsx', '*.tsx' }
local extensions = vim.list_extend({ '*.css', '*.scss', '*.rb', '*.md', '*.json' }, jsExtensions)
local ts = require'_utils'

local group = vim.api.nvim_create_augroup("formatting", { clear = true })
vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = extensions,
  callback = function()
    if vim.b.lsp_enabled ~= false then
      vim.lsp.buf.formatting_seq_sync(nil, 2000)
    end
  end
})

vim.api.nvim_create_autocmd('BufWritePre', {
  group = group,
  pattern = jsExtensions,
  callback = function()
    if vim.b.lsp_enabled ~= false then
      ts.organize_imports()
    end
  end
})


return M
