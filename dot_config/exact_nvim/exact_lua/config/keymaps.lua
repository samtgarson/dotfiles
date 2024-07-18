-- Set Leader to Space
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- Map more convenient window keys
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, remap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, remap = true })

vim.keymap.set("n", "<leader>l", ":set list!<CR>", { silent = true, remap = true, desc = "Toggle paragraph symbols" })

-- Quickly close all buffers
vim.keymap.set("n", "<leader>W", ":%bd!<CR>", { silent = true, remap = true, desc = "Close all buffers" })

-- clear nvim search highlight on esc
vim.keymap.set("n", "<esc>", ":noh<CR><esc>", { silent = true, remap = false })

-- in normal mode, tab and shift-tab will move between tabs
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true, desc = "Next tab" })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { silent = true, remap = true, desc = "Previous tab" })

-- LSP mapping
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show current diagnostic" })
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Buffer local mappings.
    local opts = function(desc)
      return { buffer = ev.buf, desc = desc }
    end
    vim.keymap.set('n', 'gd', function()
      require('telescope.builtin').lsp_definitions({ jump_type = "tab", reuse_win = true })
    end, opts("Go to definition"))
    vim.keymap.set('n', 'gr', function()
      require('telescope.builtin').lsp_references({ jump_type = "tab", reuse_win = true, show_line = false })
    end, opts("Go to references"))
    vim.keymap.set('n', 'gD', function()
      require('telescope.builtin').lsp_type_definitions({ jump_type = "tab", reuse_win = true, show_line = false })
    end, opts("Go to type definitions"))
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts("Show hover"))
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Go to implementation"))
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts("Show signature help"))
    vim.keymap.set({ 'n', 'v' }, '<leader>c', vim.lsp.buf.code_action, opts("Show code actions"))
    vim.keymap.set('n', '<leader>C', function()
      if vim.fn.expand('%:t') == 'package.json' then
        require('telescope').extensions.package_info.package_info()
      else
        require('vtsls-commands').select_command()
      end
    end, opts("Typescript code actions"))
    vim.keymap.set('n', '<leader>F', function()
      vim.lsp.buf.format { async = true }
    end, opts("Format buffer"))
  end,
})
