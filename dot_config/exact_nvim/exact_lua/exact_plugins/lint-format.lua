-- http://www.lazyvim.org/plugins/linting

--- @param events table<string> # Event to trigger linters
--- @param linters_by_ft table<string, table<string>> # Linters by filetype
--- @param linters table<string, lint.Linter|fun():lint.Linter> # Linters
local function setup_lint(events, linters_by_ft, linters)
  local Helpers = {}

  local lint = require("lint")

  function Helpers.debounce(ms, fn)
    local timer = vim.uv.new_timer()
    return function(...)
      local argv = { ... }
      timer:start(ms, 0, function()
        timer:stop()
        vim.schedule_wrap(fn)(unpack(argv))
      end)
    end
  end

  function Helpers.lint()
    -- Use nvim-lint's logic first:
    -- * checks if linters exist for the full filetype first
    -- * otherwise will split filetype by "." and add all those linters
    -- * this differs from conform.nvim which only uses the first filetype that has a formatter
    local names = lint._resolve_linter_by_ft(vim.bo.filetype)

    -- Create a copy of the names table to avoid modifying the original.
    names = vim.list_extend({}, names)

    -- Add fallback linters.
    if #names == 0 then
      vim.list_extend(names, lint.linters_by_ft["_"] or {})
    end

    -- Add global linters.
    vim.list_extend(names, lint.linters_by_ft["*"] or {})

    -- Filter out linters that don't exist or don't match the condition.
    local ctx = { filename = vim.api.nvim_buf_get_name(0) }
    ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
    names = vim.tbl_filter(function(name)
      local linter = lint.linters[name]
      if not linter then
        print("Linter not found: " .. name, { title = "nvim-lint" })
      end
      return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
    end, names)

    -- Run linters.
    if #names > 0 then
      lint.try_lint(names)
    end
  end

  for name, linter in pairs(linters) do
    if type(linter) == "table" and type(lint.linters[name]) == "table" then
      lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
      if type(linter.prepend_args) == "table" then
        lint.linters[name].args = lint.linters[name].args or {}
        vim.list_extend(lint.linters[name].args, linter.prepend_args)
      end
    else
      lint.linters[name] = linter
    end
  end

  lint.linters_by_ft = linters_by_ft

  vim.api.nvim_create_autocmd(events, {
    group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
    callback = Helpers.debounce(100, Helpers.lint),
  })
end

return {
  {
    'mfussenegger/nvim-lint',
    event = "VeryLazy",
    opts = {
      -- Event to trigger linters
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
      linters_by_ft = {
        typescript = { "eslint_d" },
        javascript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        ruby = { "rubocop" }
      },
      linters = {}
    },
    config = function(_, opts)
      require('lint').linters.rubocop.cmd = 'bundle'
      require('lint').linters.rubocop.args = {
        'exec',
        'rubocop',
        '--format',
        'json',
        '--force-exclusion',
        '--server',
        '--stdin',
        function() return vim.api.nvim_buf_get_name(0) end,
      }

      setup_lint(opts["events"], opts["linters_by_ft"], opts["linters"])
    end
  },
  {
    'stevearc/conform.nvim',
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>F",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters = {
        rubocop = {
          command = "bundle",
          args = {
            "exec",
            "rubocop",
            "--server",
            "-a",
            "-f",
            "quiet",
            "--stderr",
            "--stdin",
            "$FILENAME",
          },
        }
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        ruby = { "rubocop" }
      },
    },
  }
}
