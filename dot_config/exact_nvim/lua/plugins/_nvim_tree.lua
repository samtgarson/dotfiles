vim.g["nvim_tree_width_allow_resize"] = 1

vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '-', ':NvimTreeToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>n', ':NvimTreeFindFile<CR>', {noremap = true})

require'nvim-tree'.setup {
  open_on_setup = false,
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
    custom = { '.git', 'node_modules', '.cache', 'tmp', '.DS_Store'  }
  },
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        enable = true,
        exclude = {
          filetype = {'fugitive'},
          buftype = {'terminal'}
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
      },
      glyphs = {
        default = '',
        git = {
          unstaged = "○",
          staged = "●",
          unmerged = "⊜",
          renamed = "⊙",
          untracked = "⊕",
          deleted = "⊗",
          ignored = "⊘"
        },
        folder = {
          arrow_open = "▾",
          arrow_closed = "▸",
          default = "▸",
          open =  "▾",
          empty = "▸",
          empty_open = "▾",
          symlink = "▸",
          symlink_open = "▾",
        }
      }
    }
  }
}
