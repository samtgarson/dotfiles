return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  keys = {
    { "<C-n>", ':NvimTreeToggle<CR>', desc = "Toggle file browser" },
    { "-", ':NvimTreeToggle<CR>', desc = "Toggle file browser" },
    { "<leader>n", ':NvimTreeFindFile<CR>', desc = "Find current file in file browser" },
  },
  config = {
    open_on_setup = false,
    trash = { cmd = vim.fn.has('macunix') and 'trash' or 'gio trash' },
    update_focused_file = {
      enable = true
    },
    diagnostics = {
      enable = true,
      icons = {
        warning = "×",
        error = "×",
      }
    },
    filters = {
      custom = { '\\.git', 'node_modules', '\\.cache', 'tmp\\W', '\\.DS_Store', '\\.next' }
    },
    actions = {
      open_file = {
        quit_on_open = true,
        window_picker = {
          enable = true,
          exclude = {
            filetype = { 'fugitive' },
            buftype = { 'terminal' }
          }
        }
      },
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      special_files = { 'README.md', '.env' },
      highlight_opened_files = 'icon',
      root_folder_modifier = ':~',
      icons = {
        padding = ' ',
        show = {
          folder = true,
          file = false,
          folder_arrow = false,
          git = false
        },
        glyphs = {
          default = '',
          folder = {
            arrow_open = "▾",
            arrow_closed = "▸",
            default = "▸",
            open = "▾",
            empty = "▸",
            empty_open = "▾",
            symlink = "▸",
            symlink_open = "▾",
          }
        }
      }
    }
  }
}
