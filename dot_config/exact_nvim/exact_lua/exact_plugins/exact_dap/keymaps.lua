local M = {}

local whichkey = require "which-key"

function M.setup()
  whichkey.add({
    silent = true,
    noremap = true,
    nowait = false,
    {
      mode = "n",
      { "<Leader>d", group = "DAP" },
      { "<Leader>R", "<cmd>lua require'dap'.run_to_cursor()<cr>",                               desc = "Run to Cursor",          mode = "n" },
      { "<Leader>E", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",        desc = "Evaluate Input",         mode = "n" },
      { "<Leader>C", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", desc = "Conditional Breakpoint", mode = "n" },
      { "<Leader>U", "<cmd>lua require'dapui'.toggle()<cr>",                                    desc = "Toggle UI",              mode = "n" },
      { "<Leader>b", "<cmd>lua require'dap'.step_back()<cr>",                                   desc = "Step Back",              mode = "n" },
      { "<Leader>c", "<cmd>lua require'dap'.continue()<cr>",                                    desc = "Continue",               mode = "n" },
      { "<Leader>d", "<cmd>lua require'dap'.disconnect()<cr>",                                  desc = "Disconnect",             mode = "n" },
      { "<Leader>e", "<cmd>lua require'dapui'.eval()<cr>",                                      desc = "Evaluate",               mode = "n" },
      { "<Leader>g", "<cmd>lua require'dap'.session()<cr>",                                     desc = "Get Session",            mode = "n" },
      { "<Leader>h", "<cmd>lua require'dap.ui.widgets'.hover()<cr>",                            desc = "Hover Variables",        mode = "n" },
      { "<Leader>S", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>",                           desc = "Scopes",                 mode = "n" },
      { "<Leader>i", "<cmd>lua require'dap'.step_into()<cr>",                                   desc = "Step Into",              mode = "n" },
      { "<Leader>o", "<cmd>lua require'dap'.step_over()<cr>",                                   desc = "Step Over",              mode = "n" },
      { "<Leader>p", "<cmd>lua require'dap'.pause.toggle()<cr>",                                desc = "Pause",                  mode = "n" },
      { "<Leader>q", "<cmd>lua require'dap'.close()<cr>",                                       desc = "Quit",                   mode = "n" },
      { "<Leader>r", "<cmd>lua require'dap'.repl.toggle()<cr>",                                 desc = "Toggle Repl",            mode = "n" },
      { "<Leader>s", "<cmd>lua require'dap'.continue()<cr>",                                    desc = "Start",                  mode = "n" },
      { "<Leader>t", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",                           desc = "Toggle Breakpoint",      mode = "n" },
      { "<Leader>x", "<cmd>lua require'dap'.terminate()<cr>",                                   desc = "Terminate",              mode = "n" },
      { "<Leader>u", "<cmd>lua require'dap'.step_out()<cr>",                                    desc = "Step Out",               mode = "n" },
    },
    { "<Leader>e", "<cmd>lua require'dapui'.eval()<cr>", desc = "Evaluate", mode = "v" },
  })
end

return M
