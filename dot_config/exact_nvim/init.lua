CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

-- Set Leader to Space
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

require("config/options")
require("config/lazy")
require("overmind")
