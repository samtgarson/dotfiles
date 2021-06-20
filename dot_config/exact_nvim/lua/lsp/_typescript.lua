
local exports = {}

function exports.setup(on_attach)
  require'lspconfig'.typescript.setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.resolved_capabilities.document_formatting = false
    end
  }
end

return exports
