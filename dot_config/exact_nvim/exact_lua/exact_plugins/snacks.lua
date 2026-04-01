return {
{
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      notifier = {
        enabled = true,
        style = "minimal",
      },
      quickfile = { enabled = true },
      statuscolumn = { enabled = true },
      input = {
        enabled = true,
        win = {
          backdrop = 60,
          border = "none",
          keys = {
            i_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "i", expr = true },
          },
        }
      },
      lazygit = {
        configure = true,
        config = {
          gui = { nerdFontsVersion = "" }
        }
      },
      scroll = { enabled = true },
      picker = {
        enabled = true,
        prompt = "❯ ",
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          frecency = true,
        },
        formatters = {
          file = { filename_first = true }
        },
        title = "",
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
            border = "none",
          },
          list = {
            border = "none",
          },
          preview = {
            border = "none",
          },
          prompt = {
            border = "none",
          },
        },
        icons = {
          files = { enabled = false },
        }
      },
      scratch = {
        win = {
          border = "none",
        }
      },
      rename = {
        win = {
          border = "none",
        }
      },
    },
    keys = {
      { "<leader>.",  function() Snacks.scratch() end,               desc = "Toggle Scratch Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end,    desc = "Rename File" },
      { "<leader>G",  function() Snacks.lazygit() end,               desc = "Lazygit Current File History" },
      { "<c-/>",      function() Snacks.terminal() end,              desc = "Toggle Terminal" },
      { "<leader>Nn", function() Snacks.notifier.hide() end,         desc = "Dismiss All Notifications" },
      { "<leader>Nh", function() Snacks.notifier.show_history() end, desc = "Show notifier history" },
      {
        "<Leader>f",
        function()
          vim.cmd("Neotree close")
          Snacks.picker.grep({ title = "" })
        end,
        desc = "Open project search"
      },
      {
        "<C-p>",
        function()
          vim.cmd("Neotree close")
          Snacks.picker.files({
            title = "",
            hidden = true,
            ignored = true,
            exclude = {
              "node_modules",
              ".git",
              ".next",
              "tmp/",
              ".yalc",
              "dist",
              "coverage",
              "vendor/bundle"
            }
          })
        end,
        desc = "Open file finder"
      },
    },
  }
}
