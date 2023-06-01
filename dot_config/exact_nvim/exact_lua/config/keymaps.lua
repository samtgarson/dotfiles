-- Set Leader to Space
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Map more convenient window keys
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, remap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, remap = true })

-- Toggle paragraph symbols
vim.keymap.set("n", "<leade:q<CR>r>l", ":set list!<CR>", { silent = true, remap = true })

-- Handy find and replace shortcut
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//g<left><left>', { remap = false })

-- Quickly close all buffers
vim.keymap.set("n", "<leader>W", ":%bd!<CR>", { silent = true })

-- clear nvim search highlight on esc
vim.keymap.set("n", "<esc>", ":noh<CR><esc>", { silent = true, remap = false })

-- in normal mode, tab and shift-tab will move between tabs
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { silent = true, remap = true })

-- LSP mapping
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', function()
      require('telescope.builtin').lsp_definitions({ jump_type = "tab" })
    end, opts)
    vim.keymap.set('n', 'gr', function()
      require('telescope.builtin').lsp_references({ jump_type = "tab", show_line = false })
    end, opts)
    vim.keymap.set('n', 'gD', function()
      require('telescope.builtin').lsp_type_definitions({ jump_type = "tab", show_line = false })
    end, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>C', function()
      require('vtsls-commands').select_command()
    end, opts)
    vim.keymap.set('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
