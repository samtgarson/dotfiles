return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "VeryLazy" },
    init = function()
      vim.g.omni_sql_no_default_maps = true
      vim.diagnostic.config {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = " ●",
          suffix = " "
        }, -- disable virtual text
        -- virtual_lines = false,
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          padding = 2,
          focusable = false,
          style = "minimal",
          border = "solid",
          -- border = Util.generate_borderchars("thick", "tl-t-tr-r-bl-b-br-l"),
          source = true,
          header = "",
          prefix = "",
          -- pad_top = 1,
          -- pad_bottom = 1,
        }
      }
    end,
    dependencies = {
      "b0o/SchemaStore.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "yioneko/nvim-vtsls",
    },
    config = function()
      require('mason').setup()

      local capabilities = require('blink.cmp').get_lsp_capabilities(vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require 'lsp-file-operations'.default_capabilities()
      ))

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      -- Configure all LSP servers with shared settings
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities
      })

      -- Server-specific configs are in after/lsp/<server_name>.lua
      require("mason-lspconfig").setup {
        ensure_installed = {
          'cssmodules_ls',
          'html',
          'jsonls',
          'lua_ls',
          'prismals',
          'sorbet',
          'tailwindcss',
          'vtsls',
          'yamlls',
        },
        automatic_enable = true
      }
    end
  },
  {
    'kosayoda/nvim-lightbulb',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl_mode = "blend", text = "" },
    }
  },
  {
    "smjonas/inc-rename.nvim",
    lazy = false, -- causes delay in command line
    config = true,
    keys = {
      {
        "<leader>R",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename Symbol"
      }
    },
  },
  {
    'dmmulroy/tsc.nvim',
    ft = { 'typescript', 'typescriptreact' },
    opts = {
      bin_path = require("utils").home_dir .. "/.asdf/shims/tsc"
    }
  },
  {
    'stevearc/overseer.nvim',
    lazy = false,
    opts = {
      templates = { "npm", "eslint" },
      dap = false
    },
    keys = {
      {
        "<leader>T",
        function()
          require("overseer").run_template()
        end,
        desc = "Run a task"
      }
    },
  }
}
