return {
  "nvim-lua/plenary.nvim",
  { "neoclide/jsonc.vim", ft = "json" },
  { "suy/vim-context-commentstring", event = "VeryLazy" },
  { "tpope/vim-eunuch", cmd = { 'Move', 'Rename', 'Delete', 'Remove', 'Duplicate' } },
  { "tpope/vim-rails", ft = "ruby", cmd = "Rails" },
  { "luukvbaal/stabilize.nvim", lazy = false },
  {
    "svermeulen/vim-easyclip",
    event = "VeryLazy",
    init = function()
      vim.api.nvim_set_keymap('n', 'm', 'gm', { noremap = true })
    end
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
  -- {
  --   "zbirenbaum/copilot.lua",
  --   event = "VeryLazy",
  --   config = {
  --     suggestion = {
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<Tab>",
  --         next = "<C-n>",
  --         prev = "<C-p>",
  --       }
  --     },
  --     filetypes = {
  --       yaml = false,
  --       markdown = false,
  --       help = false,
  --       gitcommit = false,
  --       gitrebase = false,
  --       hgcommit = false,
  --       svn = false,
  --       cvs = false,
  --       ["."] = false,
  --     },
  --   }
  -- },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    config = true,
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
  }
}