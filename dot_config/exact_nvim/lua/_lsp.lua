local status = require('lsp-status')
status.config {
  current_function = false,
  diagnostics = false
}
status.register_progress()

-- Autoformat on save
vim.api.nvim_command('augroup AutoFormatOnSave')
vim.api.nvim_command('autocmd!')
vim.api.nvim_command('autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 1000)')
vim.api.nvim_command('autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 1000)')
vim.api.nvim_command('autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 1000)')
vim.api.nvim_command('autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 1000)')
vim.api.nvim_command('augroup END')

-- Mappings
local opts = { noremap=true, silent=true }

local on_attach = function(client, bufnr)
  status.register_client(client.id, client.name)
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
  'ruby',
  'tailwindcss',
  'typescript',
  'yaml'
}

local function setup_servers()
  require'lspinstall'.setup()
  local installed_servers = require'lspinstall'.installed_servers()

  for _, server in pairs(required_servers) do
    if not vim.tbl_contains(installed_servers, server) then
      require'lspinstall'.install_server(server)
      print('Installed ' .. server .. ' language server')
    end

    local moduleName = 'lsp._' .. server
    if require'_utils'.moduleExists(moduleName) then
      require(moduleName).setup(on_attach)
    else
      local config = require'lspconfig'[server]
      config.setup {
        on_attach = on_attach,
        capabilities = status.capabilities
      }
    end
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

