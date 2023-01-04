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
vim.keymap.set("v", "<C-r>", '"hy:%s/<C-r>h//g<left><left>', { silent = true, remap = true })

-- Quickly close all buffers
vim.keymap.set("n", "<leader>w", ":%bd!<CR>", { silent = true })

-- clear nvim search highlight on esc
vim.keymap.set("n", "<esc>", ":noh<CR><esc>", { silent = true, remap = false })

-- in normal mode, tab and shift-tab will move between tabs
vim.keymap.set("n", "<Tab>", ":tabnext<CR>", { silent = true, remap = true })
vim.keymap.set("n", "<S-Tab>", ":tabprevious<CR>", { silent = true, remap = true })
