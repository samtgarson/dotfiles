local DEBUGGER_PATH = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug"

local M = {}

function M.setup()
  require("dap-vscode-js").setup {
    node_path = "node",
    debugger_path = DEBUGGER_PATH,
    -- debugger_cmd = { "js-debug-adapter" },
    adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost", "node-debug2-adapter" }, -- which adapters to register in nvim-dap
  }

  for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
    require("dap").configurations[language] = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch script",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Playwright Tests",
        trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/.bin/playwright",
          "test",
          "${file}",
          "--headed",
          "--workers=1"
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
      {
        type = "node-debug2-adapter",
        request = "attach",
        name = "BAF: Node",
        skipFiles = { "<node_internals>/**" },
        cwd = "${workspaceFolder}/web",
        port = 9229
      }
    }
  end

  for _, language in ipairs { "typescriptreact", "javascriptreact" } do
    require("dap").configurations[language] = {
      {
        type = "pwa-chrome",
        name = "Attach - Remote Debugging",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}",
      },
      {
        type = "pwa-chrome",
        name = "Launch Chrome",
        request = "launch",
        url = "http://localhost:3000",
      },
    }
  end
end

return M
