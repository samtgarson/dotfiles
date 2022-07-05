
local M = {}

function M.setup(base)
  return {
    on_attach = function(client, bufnr)
      base.on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end
  }
end

return M
