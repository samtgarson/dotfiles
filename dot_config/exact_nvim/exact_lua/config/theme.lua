local M = {}

M.is_conductor = vim.env.CONDUCTOR_ROOT_PATH ~= nil

M.colorscheme = M.is_conductor and "kanagawa-dragon" or "tokyonight"

return M
