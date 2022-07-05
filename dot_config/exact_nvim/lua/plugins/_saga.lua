local saga = require 'lspsaga'


saga.init_lsp_saga({
    -- "single" | "double" | "rounded" | "bold" | "plus"
    border_style = "single",
    -- when cursor in saga window you config these to move
    move_in_saga = { prev = '<C-p>',next = '<C-n>'},
    diagnostic_header = { " ", " ", " ", "ﴞ " },
    -- show diagnostic source
    show_diagnostic_source = true,
    -- add bracket or something with diagnostic source, just have 2 elements
    diagnostic_source_bracket = {},
    -- if true can press number to execute the codeaction in codeaction window
    code_action_num_shortcut = true,
    -- separator in finder
    -- finder_separator = "  ",
    -- preview lines of lsp_finder and definition preview
    max_preview_lines = 10,
    finder_action_keys = {
        open =  { 'o', '<CR>' },
        vsplit = "v",
        split = "i",
        tab = "t",
        quit = { 'q', '<ESC>' },
        scroll_down = "<C-f>",
        scroll_up = "<C-b>", -- quit can be a table
    },
    code_action_keys = {
        quit = "q",
        exec = "<CR>",
    },
    rename_action_quit = "<C-c>",
    -- definition_preview_icon = "  ",
    -- if you don't use nvim-lspconfig you must pass your server name and
    -- the related filetypes into this table
    -- like server_filetype_map = { metals = { "sbt", "scala" } }
    -- server_filetype_map = {},
})
