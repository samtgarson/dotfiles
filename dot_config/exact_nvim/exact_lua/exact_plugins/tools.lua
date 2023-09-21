return {
  "nvim-lua/plenary.nvim",
  { "neoclide/jsonc.vim",       ft = "json" },
  { "tpope/vim-eunuch",         cmd = { 'Move', 'Rename', 'Delete', 'Remove', 'Duplicate' } },
  { "tpope/vim-rails",          ft = "ruby",                                                cmd = "Rails" },
  { "luukvbaal/stabilize.nvim", lazy = false },
  {
    "gbprod/cutlass.nvim",
    lazy = false,
    config = {
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
    },
    config = {
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
    "vim-test/vim-test",
    keys = {
      { "t<C-n>", ":TestNearest<CR>", mode = "n", desc = "Run the nearest test to the cursor", silent = true },
      { "t<C-f>", ":TestFile<CR>",    mode = "n", desc = "Run all the tests in this file",     silent = true },
      { "t<C-s>", ":TestSuite<CR>",   mode = "n", desc = "Run the entire test suite",          silent = true },
      { "t<C-l>", ":TestLast<CR>",    mode = "n", desc = "Re-run the last test that was run",  silent = true }
    },
    init = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#javascript#jest#file_pattern'] = "\v((test|__tests__/).*|(spec|test)?).(js|jsx|ts|tsx)$"
    end
  },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    branch = 'jsx',
    config = true
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { "z",  "<Plug>(leap-forward-to)",   mode = "n", desc = "Leap to a character" },
      { "Z",  "<Plug>(leap-backward-to)",  mode = "n", desc = "Leap to a character" },
      { "gz", "<Plug>(leap-cross-window)", mode = "n", desc = "Leap to a character in another window" },
    },
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = false
    end
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<Leader>th", ":ToggleTerm size=15 direction=horizontal<CR>", mode = "n", desc = "Open a horizontal terminal" },
      { "<Leader>tv", ":ToggleTerm size=80 direction=vertical<CR>",   mode = "n", desc = "Open a vertical terminal" },
      { "<Leader>tf", ":ToggleTerm direction=float<CR>",              mode = "n", desc = "Open a floating terminal" },
      { "<Leader>G",  desc = "Open Lazygit" }
    },
    config = function()
      require('toggleterm').setup {
        shade_terminals = false,
        float_opts = {
          border = "curved",
        }
      }

      local Terminal = require('toggleterm.terminal').Terminal
      local lazygit  = Terminal:new({
        hidden = true,
        cmd = "lazygit",
        dir = "git_dir",
        direction = "tab",
        display_name = "LazyGit",
      })

      vim.keymap.set('n', '<leader>G', function()
        lazygit:toggle()
      end)
    end
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
      vim.g.gitblame_message_template = '<date> • <author> • <summary>'
    end
  },
  {
    'andymass/vim-matchup',
    event = 'VeryLazy',
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
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
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader>d"] = { name = "+debug" },
        ["<leader>t"] = { name = "+terminal" },
      },
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },
}
