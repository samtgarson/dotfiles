CONFIG_PATH = vim.fn.stdpath("config")
DATA_PATH = vim.fn.stdpath("data")
CACHE_PATH = vim.fn.stdpath("cache")

require("config/keymaps")
require("config/options")
require("config/lazy")
require("overmind")
