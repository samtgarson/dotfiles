return {
  "mistweaverco/kulala.nvim",
  -- Load early so the session save/restore hooks are registered
  event = { "SessionLoadPost", "VimLeavePre" },
  ft = { "http", "rest" },
  keys = {
    { "<leader>Hs", desc = "Send request" },
    { "<leader>Ha", desc = "Send all requests" },
    { "<leader>Hb", desc = "Open scratchpad" },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>H",
    ui = {
      display_mode = "split",
      split_direction = "right",
    },
  },
}
