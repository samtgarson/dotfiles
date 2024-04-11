-- Show line numbers relative from current line
vim.o.relativenumber = true
vim.o.number = true

-- Use 2 spaces for tabs everywhere
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- Always show the cursor line
vim.o.cursorline = true

-- Better clipboard integration
vim.o.clipboard = 'unnamedplus'

-- Show completion in vim commandbar
vim.o.wildmenu = true
vim.o.wildignore = 'node_modules/*,.git/*,.DS_Store,*/tmp/*'

-- Wrap text
vim.o.wrap = true

-- start scrolling when 8 lines from the end of the file
vim.o.scrolloff = 15

-- Better handling for text case in vim commands
vim.o.ignorecase = true
vim.o.smartcase = true

-- Use tabs and windows when switching with quickfix
vim.o.switchbuf = 'usetab'

-- Ensure plugins which regularly update do so frequently
vim.o.updatetime = 100

-- Characters to show when highlighting whitespace
vim.o.listchars = 'eol:$,tab:▸ ,trail:~,space:·,nbsp:␣,extends:❯,precedes:❮'

-- Enable mouse in all modes
vim.o.mouse = 'a'
vim.o.mousemoveevent = true

-- Ensure EOL is always present when saving
vim.o.fixendofline = true

-- Experimental: only show command line when active
vim.o.cmdheight = 1

-- Open splits more naturally
vim.o.splitbelow = true
vim.o.splitright = true

-- Automatically clear trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", { pattern = "*", command = "%s/\\s\\+$//e" })

-- Set filetype correctly with .tmpl files
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.*.tmpl",
  callback = function(ctx)
    local i, j = string.find(ctx.file, "%.+[^%.]+")
    local file = string.sub(ctx.file, i + 1, j)
    vim.cmd("set filetype=" .. file)
  end
})

-- Handle true color correctly
vim.o.termguicolors = true

-- Shortcut for piping commands into quickfix window
-- (doesn't seem like this is possible in lua yet)
vim.cmd [[
function! Quickfix(...)
  cexpr system(join(a:000, ' ')) | cw
endfunction
command! -nargs=1 Qf call Quickfix(<f-args>)

command! EslintErrors call Quickfix('node_modules/.bin/eslint --format=unix . --ignore-path .gitignore')
]]

-- Hide some unnecessary messages
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true, s = true, F = true, S = true, l = false })

vim.opt.splitkeep = "screen"

-- Fix markdown intentation settings
vim.g.markdown_recommended_style = 0
