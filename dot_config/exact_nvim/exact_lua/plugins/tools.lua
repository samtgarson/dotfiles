return {
  "nvim-lua/plenary.nvim",
  { "neoclide/jsonc.vim", ft = "json" },
  { "suy/vim-context-commentstring", event = "VeryLazy" },
  { "tpope/vim-eunuch", cmd = { 'Move', 'Rename', 'Delete', 'Remove', 'Duplicate' } },
  { "tpope/vim-rails", ft = "ruby", cmd = "Rails" },
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
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = {
      file_panel = { use_icons = false },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    keys = {
      { "<Leader>G", ":LazyGit<CR>", mode = "n", desc = "Open Lazygit" }
    },
    init = function()
      vim.g.lazygit_floating_window_scaling_factor = 1
      vim.g.lazygit_floating_window_use_plenary = 0
    end
  },
  {
    "mbbill/undotree",
    keys = {
      { "<Leader>u", ":UndotreeToggle<cr>", mode = "n", desc = "Toggle the Undo Tree view" }
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
      { "t<C-f>", ":TestFile<CR>", mode = "n", desc = "Run all the tests in this file", silent = true },
      { "t<C-s>", ":TestSuite<CR>", mode = "n", desc = "Run the entire test suite", silent = true },
      { "t<C-l>", ":TestLast<CR>", mode = "n", desc = "Re-run the last test that was run", silent = true }
    },
    init = function()
      vim.g['test#strategy'] = 'neovim'
      vim.g['test#javascript#jest#file_pattern'] = "\v((test|__tests__/).*|(spec|test)?).(js|jsx|ts|tsx)$"
    end
  },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'tpope/vim-commentary', event = 'VeryLazy' },
  {
    'ggandor/leap.nvim',
    keys = {
      { "z", "<Plug>(leap-forward-to)", mode = "n", desc = "Leap to a character" },
      { "Z", "<Plug>(leap-backward-to)", mode = "n", desc = "Leap to a character" },
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
      { "<C-t>h", ":ToggleTerm size=15 direction=horizontal<CR>", mode = "n", desc = "Open a horizontal terminal" },
      { "<C-t>v", ":ToggleTerm size=80 direction=vertical<CR>", mode = "n", desc = "Open a vertical terminal" },
      { "<C-t>f", ":ToggleTerm direction=float<CR>", mode = "n", desc = "Open a floating terminal" },
    },
    config = true
  }
}
