local dap_breakpoint = {
  breakpoint = {
    text = "●",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  condition = {
    text = "○",
    texthl = "LspDiagnosticsSignError",
    linehl = "",
    numhl = "",
  },
  rejected = {
    text = "●",
    texthl = "LspDiagnosticsSignHint",
    linehl = "",
    numhl = "",
  },
  stopped = {
    text = "→",
    texthl = "LspDiagnosticsSignInformation",
    linehl = "DiagnosticUnderlineInfo",
    numhl = "LspDiagnosticsSignInformation",
  },
}

return {
  "mfussenegger/nvim-dap",

  dependencies = {

    -- fancy UI for the debugger
    {
      "rcarriga/nvim-dap-ui",
      opts = {
        layouts = { {
          elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
          position = "left",
          size = 40
        }, {
          elements = { {
            id = "repl",
            size = 0.5
          }, {
            id = "console",
            size = 0.5
          } },
          position = "bottom",
          size = 10
        } }
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end

        require("plugins.dap.javascript").setup()
        require('dap-ruby').setup()
      end,
    },

    -- Adapters
    { 'suketa/nvim-dap-ruby' },
    { "mxsdev/nvim-dap-vscode-js" },
    {
      "microsoft/vscode-js-debug",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
    },

    {
      'LiadOz/nvim-dap-repl-highlights',
      config = function()
        require('nvim-dap-repl-highlights').setup()
        vim.cmd [[TSInstall dap_repl]]
      end
    },

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- mason.nvim integration
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "mason.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },
  },
  keys = {
    { '<Leader>dR', function() require 'dap'.run_to_cursor() end,                        desc = "Run to Cursor" },
    { '<Leader>dE', function() require 'dapui'.eval(vim.fn.input '[Expression] > ') end, desc = "Evaluate Input" },
    {
      '<Leader>dC',
      function() require 'dap'.set_breakpoint(vim.fn.input '[Condition] > ') end,
      desc =
      "Conditional Breakpoint"
    },
    { '<Leader>dU', function() require 'dapui'.toggle() end,          desc = "Toggle UI" },
    { '<Leader>db', function() require 'dap'.step_back() end,         desc = "Step Back" },
    { '<Leader>dc', function() require 'dap'.continue() end,          desc = "Continue" },
    { '<Leader>dd', function() require 'dap'.disconnect() end,        desc = "Disconnect" },
    { '<Leader>de', function() require 'dapui'.eval() end,            desc = "Evaluate" },
    { '<Leader>dg', function() require 'dap'.session() end,           desc = "Get Session" },
    { '<Leader>dh', function() require 'dap.ui.widgets'.hover() end,  desc = "Hover Variables" },
    { '<Leader>dS', function() require 'dap.ui.widgets'.scopes() end, desc = "Scopes" },
    { '<Leader>di', function() require 'dap'.step_into() end,         desc = "Step Into" },
    { '<Leader>do', function() require 'dap'.step_over() end,         desc = "Step Over" },
    { '<Leader>dp', function() require 'dap'.pause.toggle() end,      desc = "Pause" },
    { '<Leader>dq', function() require 'dap'.close() end,             desc = "Quit" },
    { '<Leader>dr', function() require 'dap'.repl.toggle() end,       desc = "Toggle Repl" },
    { '<Leader>ds', function() require 'dap'.continue() end,          desc = "Start" },
    { '<Leader>dt', function() require 'dap'.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { '<Leader>dx', function() require 'dap'.terminate() end,         desc = "Terminate" },
    { '<Leader>du', function() require 'dap'.step_out() end,          desc = "Step Out" }
  },
  config = function()
    vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
    vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
  end,
}
