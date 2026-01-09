return {
  "nvim-lua/plenary.nvim",
  { "neoclide/jsonc.vim",       ft = "json" },
  { "tpope/vim-eunuch",         cmd = { 'Move', 'Rename', 'Delete', 'Remove', 'Duplicate' } },
  { "tpope/vim-rails",          ft = "ruby",                                                cmd = "Rails" },
  { "luukvbaal/stabilize.nvim", lazy = false },
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    opts = {
      cut_key = "m"
    }
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ['Find Under']         = '<C-d>',
        ['Find Subword Under'] = '<C-d>',
      }
    end
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader>u", ":UndotreeToggle<cr>", mode = "n", desc = "Toggle Undo Tree" }
    },
    init = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_TreeNodeShape = '•'
      vim.g.undotree_HelpLine = 0
    end
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "marilari88/neotest-vitest",
      "zidhuss/neotest-minitest"
    },
    keys = {
      { "<Leader>tn", function() require("neotest").run.run() end,                   mode = "n", desc = "Run the nearest test to the cursor",   silent = true },
      { "<Leader>tl", function() require("neotest").run.run_last() end,              mode = "n", desc = "Run the last run test",                silent = true },
      { "<Leader>tx", function() require("neotest").run.stop() end,                  mode = "n", desc = "Stop the nearest test to the cursor",  silent = true },
      { "<Leader>ta", function() require("neotest").run.attach() end,                mode = "n", desc = "Attach to nearest test to the cursor", silent = true },
      { "<Leader>to", function() require("neotest").output_panel.toggle() end,       mode = "n", desc = "Attach to nearest test to the cursor", silent = true },
      { "<Leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, mode = "n", desc = "Run all the tests in this file",       silent = true },
      { "<Leader>ts", function() require("neotest").summary.toggle() end,            mode = "n", desc = "Toggle the test summary panel",        silent = true },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require("neotest-rspec"),
          require("neotest-vitest") {
            vitestCommand = "npx vitest"
          },
          require("neotest-minitest")
        },
        icons = {
          running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        },
        floating = {
          border = "solid"
        }
      }
    end
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event = "VeryLazy",
    keys = {
      { 'S',  desc = "Add surrounding" },
      { 'ds', desc = "Delete surrounding" },
      { 'cs', desc = "Replace surrounding" },
    },
    opts = {
      mappings = {
        add = 'S',
        delete = 'ds',
        replace = 'cs'
      }
    }
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy"
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = { enabled = true },
      }
    },
    keys = {
      { "z",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "Z",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        style = "minimal",
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      input = {
        enabled = true,
        win = {
          backdrop = 60,
          border = "none",
          keys = {
            i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
          },
        }
      },
      lazygit = {
        configure = true,
        config = {
          gui = { nerdFontsVersion = "" }
        }
      },
      scroll = { enabled = true },
      picker = {
        enabled = true,
        prompt = "❯ ",
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          frecency = true,
        },
        formatters = {
          file = { filename_first = true }
        },
        title = "",
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
            border = "none",
          },
          list = {
            border = "none",
          },
          preview = {
            border = "none",
          },
          prompt = {
            border = "none",
          },
        },
        icons = {
          files = { enabled = false },
        }
      },
      scratch = {
        win = {
          border = "none",
        }
      },
      rename = {
        win = {
          border = "none",
        }
      },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
      { "<leader>G",  function() Snacks.lazygit() end,               desc = "Lazygit Current File History" },
      { "<c-/>",      function() Snacks.terminal() end,              desc = "Toggle Terminal" },
      { "<leader>Nn", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
      { "<leader>Nh", function() Snacks.notifier.show_history() end, desc = "Show notifier history" },
      {
        "<Leader>f",
        function()
          vim.cmd("Neotree close")
          Snacks.picker.grep({ title = "" })
        end,
        desc = "Open project search"
      },
      {
        "<C-p>",
        function()
          vim.cmd("Neotree close")
          Snacks.picker.files({
            title = "",
            hidden = true,
            exclude = {
              "node_modules",
              ".git",
              ".next",
              "tmp/",
              ".yalc",
              "dist",
              "coverage",
              "vendor/bundle"
            }
          })
        end,
        desc = "Open file finder"
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      headerMaxWidth = 80,
      icons = { enabled = false },
      -- showCompactInputs = true,
      helpLine = { enabled = false },
      resultsSeparatorLineChar = "―",
      openTargetWindow = {
        useScratchBuffer = false,
      },
      keymaps = {},
      previewWindow = {
        border = "none",
      },
    },
    cmd = { "GrugFar", "GrugFarWithin" },
    keys = {
      {
        "<leader>S",
        function()
          require("grug-far").toggle_instance({ instance_name = "project" })
        end,
        mode = { "n", "x" },
        desc = "Search and Replace in project",
      }
    },
  },
  {
    'f-person/git-blame.nvim',
    event = 'BufRead',
    init = function()
      vim.g.gitblame_display_virtual_text = 0
      vim.g.gitblame_date_format = '%r'
      vim.g.gitblame_message_template = '<author> (<date>) • <summary>'
    end
  },
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchpref = {
        html = { tagnameonly = 1, },
        javascript = { tagnameonly = 1, },
        typescript = { tagnameonly = 1, },
        javascriptreact = { tagnameonly = 1, },
        typescriptreact = { tagnameonly = 1, },
      }
    end,
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        opts = {
          matchup = { enable = true }
        }
      }
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },

    },
    opts = {
      icons = {
        mappings = false
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      local setDefaults = require('config.keymaps')
      setDefaults(wk)
    end,
  },
  {
    'akinsho/git-conflict.nvim',
    version = "*",
    config = true,
    keys = {
      { "<Leader>cl", ":GitConflictListQf<CR>", mode = "n", desc = "Open Git Conflicts" },
    },
  },
}
