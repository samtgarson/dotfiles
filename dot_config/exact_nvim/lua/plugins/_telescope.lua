local actions = require('telescope.actions')
local builtin = require("telescope.builtin")
local action_state = require('telescope.actions.state')

vim.api.nvim_set_keymap('n', '<Leader>f', '<cmd>NvimTreeClose<CR><cmd>Telescope custom_live_grep<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>NvimTreeClose<CR><cmd>Telescope find_files<CR>', { noremap = true })

local attach_mappings = function()
  actions.select_default:replace_if(
    function (prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local selected = picker:get_multi_selection()
      local count = 0
      for _ in pairs(selected) do
        count = count + 1
      end
      return count > 1
    end,
    function (prompt_bufnr)
      actions.smart_send_to_qflist(prompt_bufnr)
      actions.open_qflist(prompt_bufnr)
    end
  )

  return true
end

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden'
    },
    file_ignore_patterns = {
      "\\.git/*",
      "tmp/*",
      "node_modules/*"
    },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    color_devicons = false,
    set_env = {['COLORTERM'] = 'truecolor'},
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["C-q"] = actions.send_to_qflist
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
      no_ignore = true
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
    }
  }
}

require('telescope').load_extension('fzf')

builtin.custom_live_grep = function(opts)
  opts = opts or {}
  return builtin.live_grep(vim.tbl_extend("error", { attach_mappings = attach_mappings }, opts))
end