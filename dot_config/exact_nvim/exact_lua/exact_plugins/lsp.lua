return {
  {
    'williamboman/mason-lspconfig.nvim',
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.omni_sql_no_default_maps = true
      vim.diagnostic.config {
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
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
          source = "always",
          header = "",
          prefix = "",
          -- pad_top = 1,
          -- pad_bottom = 1,
        }
      }
    end,
    dependencies = {
      "b0o/SchemaStore.nvim",
      "folke/neodev.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "yioneko/nvim-vtsls",
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
          -- 'tsserver',
          'yamlls',
          'vtsls',
          -- 'solargraph',
        }
      }

      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

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

      local null_ls = require("null-ls")
      null_ls.setup({
        debounce = 150,
        sources = {
          null_ls.builtins.code_actions.eslint_d,
          null_ls.builtins.diagnostics.eslint_d,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.prettier,
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
        ["vtsls"] = function()
          require("lspconfig.configs").vtsls = require("vtsls").lspconfig
          require("lspconfig").vtsls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
              typescript = {
                inlayHints = {
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  enumMemberValues = { enabled = true },
                }
              },
            },
            handlers = {
              source_definition = function(err, result)
                print("handler", vim.inspect(result))
                if result == nil or vim.tbl_isempty(result) then
                  return nil
                end


                if vim.tbl_islist(result) then
                  local filtered = {}
                  for key, value in pairs(result) do
                    if not string.match(value.uri, "react/index.d.ts") then
                      filtered[key] = value
                    end
                  end
                  vim.lsp.util.set_qflist(util.locations_to_items(filtered))
                else
                  vim.lsp.util.jump_to_location(result)
                end
                return nil
              end
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
        end,
        ["sorbet"] = function()
          require("lspconfig").sorbet.setup({
            root_dir = require('lspconfig.util').root_pattern('sorbet')
          })
        end,
        ["ruby_ls"] = function()
          -- helpers = require('plugins.lsp.ruby')
          require("lspconfig").ruby_ls.setup({
            cmd = { require("utils").home_dir .. "/.asdf/shims/ruby-lsp" },
            capabilities = capabilities,
            on_attach = on_attach,
            init_options = {
              formatter = "none",
              enabledFeatures = {
                'codeActions',
                'codeLens',
                'completion',
                'definition',
                'documentHighlights',
                'documentLink',
                'documentSymbols',
                'foldingRanges',
                'hover',
                'inlayHint',
                'onTypeFormatting',
                'selectionRanges',
                'signatureHelp',
                'workspaceSymbol'
                -- 'diagnostics',
                -- 'formatting',
                -- 'semanticHighlighting',
              },
            }
          })
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
        library.types = true
      end,
    }
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
      bin_path = "/Users/samgarson/.asdf/shims/tsc"
    }
  }
}
