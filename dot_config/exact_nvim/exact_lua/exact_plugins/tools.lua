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
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    keys = {
      {
        "<Tab>",
        function()
          local copilot = require("copilot.suggestion")
          if copilot.is_visible() then
            copilot.accept()
          else
            -- Enter a tab character like normal
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
          end
        end,
        desc = "Accept Copilot suggestion",
        remap = true,
        silent = true,
        mode = "i"
      },
      { "<Leader>cpn", ":lua require('copilot.panel').jump_next()<CR>", mode = "n", desc = "Next Copilot suggestion" },
      { "<Leader>cpp", ":lua require('copilot.panel').jump_prev()<CR>", mode = "n", desc = "Previous Copilot suggestion" },
      { "<Leader>cpa", ":lua require('copilot.panel').accept()<CR>",    mode = "n", desc = "Accept Copilot suggestion" },
      { "<Leader>cpd", ":lua require('copilot.panel').decline()<CR>",   mode = "n", desc = "Decline Copilot suggestion" },
      { "<Leader>cpo", ":lua require('copilot.panel').open()<CR>",      mode = "n", desc = "Open Copilot panel" },
    },
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
          next = "<C-n>",
          prev = "<C-p>",
        }
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      panel = {
        enabled = true,
        auto_refresh = true
      }
    }
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
      { "<C-t>n", function() require("neotest").run.run() end,                   mode = "n", desc = "Run the nearest test to the cursor",   silent = true },
      { "<C-t>l", function() require("neotest").run.run_last() end,              mode = "n", desc = "Run the last run test",                silent = true },
      { "<C-t>x", function() require("neotest").run.stop() end,                  mode = "n", desc = "Stop the nearest test to the cursor",  silent = true },
      { "<C-t>a", function() require("neotest").run.attach() end,                mode = "n", desc = "Attach to nearest test to the cursor", silent = true },
      { "<C-t>o", function() require("neotest").output_panel.toggle() end,       mode = "n", desc = "Attach to nearest test to the cursor", silent = true },
      { "<C-t>f", function() require("neotest").run.run(vim.fn.expand("%")) end, mode = "n", desc = "Run all the tests in this file",       silent = true },
      { "<C-t>s", function() require("neotest").summary.toggle() end,            mode = "n", desc = "Toggle the test summary panel",        silent = true },
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
      lazygit = {
        configure = true,
        config = {
          gui = { nerdFontsVersion = "" }
        }
      },
      scroll = { enabled = true },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,            desc = "Toggle Scratch Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>G",  function() Snacks.lazygit() end,            desc = "Lazygit Current File History" },
      { "<c-/>",      function() Snacks.terminal() end,           desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end,           desc = "which_key_ignore" },
      { "<leader>un", function() Snacks.notifier.hide() end,      desc = "Dismiss All Notifications" },

    },
  },
  {
    'nvim-pack/nvim-spectre',
    keys = {
      {
        "<Leader>S",
        function() require("spectre").open() end,
        mode = "n",
        desc = "Open Spectre"
      },
    }
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
