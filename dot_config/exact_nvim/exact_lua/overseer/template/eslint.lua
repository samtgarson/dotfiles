local files = require("overseer.files")

---@param opts overseer.SearchParams
---@return string[]
local function get_candidate_package_files(opts)
  local matches = vim.fs.find("package.json", {
    upward = true,
    type = "file",
    path = opts.dir,
    stop = vim.fn.getcwd() .. "/..",
    limit = math.huge,
  })

  return matches
end

---@param opts overseer.SearchParams
---@return string|nil
local function get_package_file(opts)
  local candidate_packages = get_candidate_package_files(opts)
  -- go through candidate package files from closest to the file to least close
  for _, package in ipairs(candidate_packages) do
    local data = files.load_json_file(package)
    if data.scripts or data.workspaces then
      return package
    end
  end
  return nil
end

---@type overseer.TemplateDefinition
return {
  name = "Run eslint",
  description = "Run eslint on the current project",
  cache_key = function(opts)
    return get_package_file(opts)
  end,
  condition = {
    callback = function(opts)
      local matches = get_package_file(opts)
      return #matches > 0
    end
  },
  builder = function()
    ---@type overseer.TaskDefinition
    return {
      cmd = { "npx" },
      args = { "eslint", "." },
      env = {
        NODE_OPTIONS = "--max-old-space-size=8192"
      },
      components = {
        "default",
        { "on_output_parse",                problem_matcher = "$eslint-stylish" },
        { "on_result_diagnostics_quickfix", open = true },
      },
    }
  end,
}
