return {
  {
    "antosha417/nvim-lsp-file-operations",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    }
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        's1n7ax/nvim-window-picker',
        version = '2.*',
        opts = {
          show_prompt = false,
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            bo = {
              filetype = { 'neo-tree', "neo-tree-popup", "notify" },
              buftype = { 'terminal', "quickfix" },
            },
          },
        }
      }
    },
    keys = {
      { "<C-n>",     ':Neotree toggle reveal<CR>', desc = "Toggle file browser" },
      { "-",         ':Neotree toggle reveal<CR>', desc = "Toggle file browser" },
      { "<leader>n", ':Neotree reveal<CR>',        desc = "Find current file in file browser" },
    },
    opts = {
      sources = {
        "filesystem",
        "document_symbols",
        "git_status",
        "buffers"
      },
      enable_diagnostics = true,
      enable_git_status = true,
      -- enable_cursor_hijack = true,
      log_level = "warn",
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false, -- only works on Windows for hidden files/directories
          hide_by_name = {
            "node_modules",
            "tmp",
            ".cache"
          },
          never_show = {
            ".DS_Store",
            "thumbs.db"
          }
        }
      },
      source_selector = {
        winbar = true,
        sources = {
          { source = "filesystem",       display_name = "Files" },
          { source = "git_status",       display_name = "Git" },
          { source = "buffers",          display_name = "Buffers" },
          { source = "document_symbols", display_name = "Symbols" },
        },
        separator = '',
        content_layout = "center"
      },
      default_component_configs = {
        container = {
          enable_character_fade = true,
          right_padding = 1
        },
        indent = {
          indent_size = 2,
          padding = 1,
        },
        icon = {
          -- default = "·"
          default = "",
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰉖",
          folder_empty_open = "󰷏",
        },
        modified = {
          symbol = "●",
        },
        -- diagnostics = {
        --   symbols = {
        --     hint = "",
        --     info = "",
        --     warning = "",
        --     error = "",
        --   }
        -- },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
        },
        git_status = {
          align = "left",
          symbols = {
            -- Change type
            added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted   = "×", -- this can only be used in the git_status source
            renamed   = "▸", -- this can only be used in the git_status source
            -- Status type
            untracked = "",
            ignored   = "",
            unstaged  = "",
            staged    = "",
            conflict  = "!",
          }
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "open_with_window_picker",
          ["x"] = "open_split",
          ["v"] = "open_vsplit",
          ["c"] = "copy_to_clipboard",
          ["<bs>"] = "close_node",
          ["m"] = "cut_to_clipboard",
          ["y"] = function(state)
            local node = state.tree:get_node()
            local filename = vim.fn.fnamemodify(node:get_id(), ":.")
            vim.fn.setreg('+', filename)
            vim.notify("Copied: " .. filename)
          end,
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg('+', filepath)
            vim.notify("Copied: " .. filepath)
          end,
        }
      },
    },

    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        {
          event = events.AFTER_RENDER,
          handler = function(state)
            if state.current_position == "left" or state.current_position == "right" then
              vim.api.nvim_win_call(state.winid, function()
                local str = require("neo-tree.ui.selector").get()
                if str then
                  _G.__cached_neo_tree_selector = str
                end
              end)
            end
          end,
        },
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      -- print("Configuring neo-tree:", vim.inspect(opts))
      require("neo-tree").setup(opts)
    end
  }
}
