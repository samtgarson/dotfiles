
local M = {}

function M.setup(base)
  local luadev = require("lua-dev").setup(base)
  return luadev
end

return M
