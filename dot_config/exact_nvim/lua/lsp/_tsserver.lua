
local M = {}

function M.setup(base)
  return {
    on_attach = function(client, bufnr)
      base.on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end,
    -- cmd = {'/Users/sam/.local/share/nvim/lspinstall/typescript/node_modules/.bin/typescript-language-server', '--stdio'},
    commands = {
      OrganizeImports = {
        require('_utils').organize_imports,
        description = "Organize Imports"
      }
    }
  }
end

return M
