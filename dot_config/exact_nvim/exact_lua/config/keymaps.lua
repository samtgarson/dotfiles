return function(wk)
  wk.add({
    silent = true,
    mode = { "n", "v" },
    remap = true,
    -- Map more convenient window keys
    { "<C-j>",      "<C-w>j",                  desc = "Move to window below" },
    { "<C-k>",      "<C-w>k",                  desc = "Move to window above" },
    { "<C-h>",      "<C-w>h",                  desc = "Move to window left" },
    { "<C-l>",      "<C-w>l",                  desc = "Move to window right" },

    { "<leader>l",  ":set list!<CR>",          desc = "Toggle paragraph symbols" },
    { "<leader>W",  ":%bd!<CR>",               desc = "Close all buffers" },
    { "<esc>",      ":noh<CR><esc>",           remap = false },

    -- in normal mode, tab and shift-tab will move between tabs
    { "<Tab>",      ":tabnext<CR>",            desc = "Next tab" },
    { "<S-Tab>",    ":tabprevious<CR>",        desc = "Previous tab" },

    -- LSP mapping
    { "<leader>e",  vim.diagnostic.open_float, desc = "Show current diagnostic" },
    { "[g",         vim.diagnostic.goto_prev,  desc = "Go to previous diagnostic" },
    { "]g",         vim.diagnostic.goto_next,  desc = "Go to next diagnostic" },

    { "]",          group = "+next" },
    { "[",          group = "+prev" },
    { "<leader>d",  group = "Debug" },
    { "<leader>t",  group = "Terminal" },
    { "<Leader>cp", group = "Copilot" }
  })

  local functions = {
    typescript_code_actions = function()
      if vim.fn.expand("%:t") == "package.json" then
        require("telescope").extensions.package_info.package_info()
      else
        require("vtsls-commands").select_command()
      end
    end,
    go_to_definition = function()
      require("telescope.builtin").lsp_definitions({ jump_type = "tab", reuse_win = true })
    end,
    go_to_references = function()
      require("telescope.builtin").lsp_references({ jump_type = "tab", reuse_win = true, show_line = false })
    end,
    go_to_type_definitions = function()
      require("telescope.builtin").lsp_type_definitions({ jump_type = "tab", reuse_win = true, show_line = false })
    end
  }

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local buffer = ev.buf

      wk.add({
        { "gd",        functions.go_to_definition,        buffer = buffer, desc = "Go to definition" },
        { "gr",        functions.go_to_references,        buffer = buffer, desc = "Go to references" },
        { "gD",        functions.go_to_type_definitions,  buffer = buffer, desc = "Go to type definitions" },
        { "K",         vim.lsp.buf.hover,                 buffer = buffer, desc = "Show hover" },
        { "gi",        vim.lsp.buf.implementation,        buffer = buffer, desc = "Go to implementation" },
        { "<C-k>",     vim.lsp.buf.signature_help,        buffer = buffer, desc = "Show signature help" },
        { "<leader>c", vim.lsp.buf.code_action,           buffer = buffer, desc = "Show code actions",      mode = { "n", "v" } },
        { "<leader>C", functions.typescript_code_actions, buffer = buffer, desc = "Typescript code actions" }
      })
    end,
  })
end
