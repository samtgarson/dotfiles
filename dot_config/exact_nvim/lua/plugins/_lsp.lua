local lsp_status = require'lsp_status'

lsp_status.setup {
  spinner = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'}
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_status.init_capabilities(capabilities)

-- Mappings
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[g', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']g', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- Ensure all servers are installed and configured
local required_servers = {
  'css',
  'efm',
  'html',
  'json',
  'lua',
  'solargraph',
  'tailwindcss',
  'typescript',
  'yaml'
}

local function setup_servers()
  require'lspinstall'.setup()
  local available_servers = require'lspinstall'.not_installed_servers()

  for _, server in pairs(required_servers) do
    if vim.tbl_contains(available_servers, server) then
      require'lspinstall'.install_server(server)
      print('Installed ' .. server .. ' language server')
    end

    local moduleName = 'lsp._' .. server
    local baseConfig = {
      on_attach = on_attach,
      capabilities = capabilities
    }

    if require'_utils'.moduleExists(moduleName) then
      require(moduleName).setup(baseConfig)
    else
      local config = require'lspconfig'[server]
      config.setup(baseConfig)
    end
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

