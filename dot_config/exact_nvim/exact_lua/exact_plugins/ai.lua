return {
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    dependencies = {
      {
        "copilotlsp-nvim/copilot-lsp",
        init = function()
          vim.g.copilot_nes_debounce = 500
        end,
      }
    },
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
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = false,
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
        ["grug-far"] = false,
        ["grug-far-history"] = false,
        ["grug-far-help"] = false,
        ["neo-tree"] = false,
      },
      panel = {
        enabled = false,
        auto_refresh = true
      },
      nes = {
        enabled = false,
        keymap = {
          accept_and_goto = "<leader>p",
          accept = false,
          dismiss = "<Esc>",
        },
      }
    }
  },
  {
    "folke/sidekick.nvim",
    opts = {
      ui = {
        icons = {
          attached = "✅"
        }
      },
      cli = {
        mux = {
          enabled = true,
        },
      },
      nes = {
        enabled = false,
      },
    },
    keys = {
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = "Select CLI",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "Detach a CLI Session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}", name = "claude" }) end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}", name = "claude" }) end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}", name = "claude" }) end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt({ name = "claude" }) end,
        mode = { "n", "x" },
        desc = "Sidekick Select Prompt",
      },
      -- Example of a keybinding to open Claude directly
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
        desc = "Sidekick Toggle Claude",
      },
    },
  }
}
