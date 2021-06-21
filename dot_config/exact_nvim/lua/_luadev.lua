local cwd = vim.fn.getcwd()

if cwd == '/Users/sam/.local/share/chezmoi' then
  local luadev = require("lua-dev").setup()
  require('lspconfig').sumneko_lua.setup(luadev)
end
