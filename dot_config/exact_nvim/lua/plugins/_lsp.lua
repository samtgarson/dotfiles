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

  -- CodeActionMenu
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>c", '<cmd>Lspsaga code_action<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>c", '<cmd><C-U>Lspsaga range_code_action<CR>', opts)

  -- renamer
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>R", '<cmd>Lspsaga rename<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>R", '<cmd>Lspsaga rename<CR>', opts)

  -- hover
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", "<cmd>Lspsaga signature_help<CR>", opts)

  -- diagnostics
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]g", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[g", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

  -- finder
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>tab split | lua vim.lsp.buf.definition()<CR>", opts)
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
  'yamlls',
}

require("nvim-lsp-installer").setup({
  automatic_installation = true
})

local lspConfig = require('lspconfig')

for _, server_name in pairs(required_servers) do
  local moduleName = 'lsp._' .. server_name
  local config = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  if require'_utils'.moduleExists(moduleName) then
    config = require(moduleName).setup(config)
  end

  lspConfig[server_name].setup(config)
end

