
local M = {}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

function M.setup(base)
  return {
    on_attach = function(client, bufnr)
      base.on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end,
    -- cmd = {'/Users/sam/.local/share/nvim/lspinstall/typescript/node_modules/.bin/typescript-language-server', '--stdio'},
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
    }
  }
end

return M
