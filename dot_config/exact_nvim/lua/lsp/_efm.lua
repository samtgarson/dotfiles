
local exports = {}

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
  formatCommand = "./node_modules/.bin/eslint --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}

-- rubocop
local rubocop = {
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "bundle exec rubocop --auto-correct-all ${INPUT}"
}

function exports.setup(on_attach)
  require'lspconfig'.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true, codeAction = true},
    filetypes = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "json",
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
        json = {prettier},
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

return exports
