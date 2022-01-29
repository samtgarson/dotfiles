require'lsp.toggle'
local lsp_spinner = require'lsp_spinner'

lsp_spinner.setup {
  spinner = {'⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'}
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
lsp_spinner.init_capabilities(capabilities)

-- Mappings
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
  lsp_spinner.on_attach(client, bufnr)
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
  'cssmodules_ls',
  'efm',
  'html',
  'jsonls',
  'sumneko_lua',
  'prismals',
  'solargraph',
  'tailwindcss',
  'tsserver',
  'yaml',
}

local function setup_servers()
  local lsp_installer_servers = require('nvim-lsp-installer.servers')

  for _, server_name in pairs(required_servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
      local moduleName = 'lsp._' .. server_name
      local config = {
        on_attach = on_attach,
        capabilities = capabilities
      }

      if require'_utils'.moduleExists(moduleName) then
        config = require(moduleName).setup(config)
      end

      server:on_ready(function ()
        server:setup(config)
      end)

      if not server:is_installed() then
        server:install()
      end
    end
  end
end

setup_servers()

