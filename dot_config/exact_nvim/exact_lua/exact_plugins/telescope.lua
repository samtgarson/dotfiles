return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "vuki656/package-info.nvim",
      dependencies = { "MunifTanjim/nui.nvim" },
    }

  },
  keys = {
    { "<Leader>f", "<cmd>Neotree close<CR><cmd>Telescope live_grep<CR>",  desc = "Open project search" },
    { "<C-p>",     "<cmd>Neotree close<CR><cmd>Telescope find_files<CR>", desc = "Open file finder" },
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
          mappings = {
            i = { ["<CR>"] = actions.select_tab_drop }
          },
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
            '--exclude', 'vendor/bundle',
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
        },
        package_info = {}
      }
    })

    telescope.load_extension('fzf')
    telescope.load_extension('ui-select')
    telescope.load_extension("package_info")
  end
}
