return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "b0o/SchemaStore.nvim",
      "doums/lsp_spinner.nvim",
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "folke/neodev.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'cssmodules_ls',
          'html',
          'jsonls',
          'prismals',
          'sorbet',
          'lua_ls',
          'tailwindcss',
          'tsserver',
          'yamlls',
          -- 'solargraph',
        }
      }

      local lsp_spinner = require('lsp_spinner')
      lsp_spinner.setup {
        spinner = { ' ⠋', ' ⠙', ' ⠹', ' ⠸', ' ⠼', ' ⠴', ' ⠦', ' ⠧', ' ⠇', ' ⠏' },
        interval = 30,
        redraw_rate = 100
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      lsp_spinner.init_capabilities(capabilities)

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local on_attach = function(client, bufnr)
        lsp_spinner.on_attach(client, bufnr)
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

      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        sources = {
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rubocop
        },
        on_attach = on_attach
      })

      require("mason-lspconfig").setup_handlers {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup { on_attach = on_attach, capabilities = capabilities }
        end,
        ["jsonls"] = function()
          require("lspconfig").jsonls.setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              json = {
                schemas = require('schemastore').json.schemas(),
                validate = { enable = true },
              },
            }
          }
        end,
        ["tsserver"] = function()
          require("lspconfig").tsserver.setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
              on_attach(client, bufnr)
            end,
            commands = {
              OrganizeImports = {
                require('config.utils').organize_imports,
                description = "Organize Imports"
              }
            }
          }
        end,
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup {
            single_file_support = true,
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                completion = {
                  workspaceWord = true,
                  callSnippet = "Both",
                },
                diagnostics = {
                  groupFileStatus = {
                    ["ambiguity"] = "Opened",
                    ["await"] = "Opened",
                    ["codestyle"] = "None",
                    ["duplicate"] = "Opened",
                    ["global"] = "Opened",
                    ["luadoc"] = "Opened",
                    ["redefined"] = "Opened",
                    ["strict"] = "Opened",
                    ["strong"] = "Opened",
                    ["type-check"] = "Opened",
                    ["unbalanced"] = "Opened",
                    ["unused"] = "Opened",
                  },
                  unusedLocalExclude = { "_*" },
                },
                format = {
                  enable = true,
                  defaultConfig = {
                    indent_style = "space",
                    indent_size = "2",
                    continuation_indent_size = "2",
                  },
                },
              },
            },
          }
        end
      }
    end
  },
  {
    "folke/neodev.nvim",
    config = {
      override = function(_root_dir, library)
        library.enabled = true
        library.plugins = true
      end,
    }
  },
  {
    'kosayoda/nvim-lightbulb',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl_mode = "blend", text = "" },
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
      }
    },
  }
}
