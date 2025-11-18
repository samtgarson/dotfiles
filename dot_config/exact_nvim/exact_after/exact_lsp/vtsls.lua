local util = require('vim.lsp.util')

-- Register vtsls config before returning
require("lspconfig.configs").vtsls = require("vtsls").lspconfig

return {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = "literals" },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      }
    },
  },
  handlers = {
    source_definition = function(err, result)
      print("handler", vim.inspect(result))
      if result == nil or vim.tbl_isempty(result) then
        return nil
      end

      if vim.tbl_islist(result) then
        local filtered = {}
        for key, value in pairs(result) do
          if not string.match(value.uri, "react/index.d.ts") then
            filtered[key] = value
          end
        end
        vim.lsp.util.set_qflist(util.locations_to_items(filtered))
      else
        vim.lsp.util.jump_to_location(result)
      end
      return nil
    end
  }
}
