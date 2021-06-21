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
    find_command = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    color_devicons = false,
    set_env = {['COLORTERM'] = 'truecolor'},
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
  }
}

builtin.custom_live_grep = function(opts)
  opts = opts or {}
  return builtin.live_grep(vim.tbl_extend("error", { attach_mappings = attach_mappings }, opts))
end
