local utils = {}

-- Check if lua module exists
function utils.moduleExists(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

-- Check whether the current buffer is empty
function utils.emptyBuffer()
    return vim.fn.empty(vim.fn.expand('%:t')) == 1
end

-- Check if the windows width is greater than a given number of columns
function utils.widthGreaterThan(cols)
    return vim.fn.winwidth(0) / 2 > cols
end

function utils.organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  print('organize imports')
  vim.lsp.buf.execute_command(params)
end


return utils
