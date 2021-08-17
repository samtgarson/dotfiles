
local M = {}

function M.setup(base)
  require'null-ls'.config { debug = true }
  require'lspconfig'['null-ls'].setup {}

  require'lspconfig'.tsserver.setup(vim.tbl_extend(
    'keep',
    {
      on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")

        ts_utils.setup {
          debug = true,
          enable_import_on_completion = true,

          -- eslint
          eslint_enable_diagnostics = true,
          eslint_show_rule_id = true,

          -- formatting
          enable_formatting = true,

          -- update imports on file move
          update_imports_on_move = true,
          require_confirmation_on_move = true,

          -- filter diagnostics
          filter_out_diagnostics_by_severity = {},
          filter_out_diagnostics_by_code = { 80001 },
        }

        -- required to fix code action ranges and filter diagnostics
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        local opts = { silent = true }
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>q", ":TSLspFixCurrent<CR>", opts)
      end,
      cmd = {'/Users/sam/.local/share/nvim/lspinstall/typescript/node_modules/.bin/typescript-language-server', '--stdio'}
    },
    base
  ))
end

return M
