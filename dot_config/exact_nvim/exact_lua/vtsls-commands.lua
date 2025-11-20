local M = {}

local commands = {
  rename_file = "Rename File",
  organize_imports = "Organize Imports",
  add_missing_imports = "Add Missing Imports",
  fix_all = "Fix All",
  remove_unused_imports = "Remove Unused Imports",
  project_errors = "Show Project Errors",
}

function M.select_command()
  local bufnr = vim.api.nvim_get_current_buf()
  local servers = vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })
  if #servers == 0 then return end

  local options = {}
  for k, _ in pairs(commands) do
    table.insert(options, k)
  end
  table.sort(options)

  local function format(item)
    return commands[item]
  end

  vim.ui.select(options, { prompt = "", format_item = format }, function(command)
    if not command then return end

    if command == "project_errors" then
      require('tsc').run()
      return
    end

    require('vtsls').commands[command](bufnr)
  end)
end

return M
