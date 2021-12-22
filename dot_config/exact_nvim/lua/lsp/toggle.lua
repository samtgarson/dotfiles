local M = {}

local check_function = function(bufnr, _)
    local ok, result = pcall(vim.api.nvim_buf_get_var, bufnr, 'lsp_enabled')
    -- No buffer local variable set, so just enable by default
    if not ok then
        return true
    end

    return result
end

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = check_function,
        virtual_text = check_function,
        signs = check_function
    })

function M.Enable()
  vim.b.lsp_enabled = true
end

function M.Disable()
  vim.b.lsp_enabled = false
end

function M.Toggle()
    if vim.b.lsp_enabled == false then
        M.Enable()
    else
        M.Disable()
    end
end

vim.cmd [[
  command! -nargs=* ToggleLsp lua require'lsp.toggle'.Toggle()
]]

return M
