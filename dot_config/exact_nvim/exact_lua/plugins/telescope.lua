return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  keys = {
    { "<Leader>f", "<cmd>NvimTreeClose<CR><cmd>Telescope live_grep<CR>",  desc = "Open project search" },
    { "<C-p>",     "<cmd>NvimTreeClose<CR><cmd>Telescope find_files<CR>", desc = "Open file finder" },
  },
  event = "VeryLazy",
  config = function()
    require("plenary")
    local telescope = require("telescope")
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        prompt_prefix = "❯ ",
        selection_caret = "▸ ",
        color_devicons = false,
        set_env = { ['COLORTERM'] = 'truecolor' },
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-a>"] = actions.send_to_qflist + actions.open_qflist
          },
          n = {
            ["<esc>"] = actions.close,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-a>"] = actions.send_to_qflist + actions.open_qflist
          },
        },
      },
      pickers = {
        find_files = {
          find_command = {
            'fd',
            '-uu',
            '--exclude', 'node_modules',
            '--exclude', '.git',
            '--exclude', '.next',
            '--exclude', 'tmp/',
            '--exclude', '.yalc',
            '--exclude', 'dist',
            '--exclude', 'coverage',
            '-t', 'f'
          }
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
        },
        ["ui-select"] = {
          layout_config = { width = { 0.4, min = 100 }, height = 0.2 },
        }
      }
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
  end
}
