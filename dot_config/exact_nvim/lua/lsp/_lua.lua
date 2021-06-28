
local M = {}

function M.setup(base)
  local luadev = require("lua-dev").setup(base)
  require('lspconfig').lua.setup(luadev)
end

return M
