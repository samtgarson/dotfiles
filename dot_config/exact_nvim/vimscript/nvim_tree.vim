let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_tab_open = 0
let g:nvim_tree_width_allow_resize = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_lsp_diagnostics = 1
let g:nvim_tree_icon_padding = ' '
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'fugitive'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
let g:nvim_tree_special_files = [ 'README.md', '.env' ]
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap - :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

let g:nvim_tree_icons = {
    \ 'default': "• ",
    \ 'git': {
    \   'unstaged': "○",
    \   'staged': "●",
    \   'unmerged': "⊜",
    \   'renamed': "⊙",
    \   'untracked': "⊕",
    \   'deleted': "⊗",
    \   'ignored': "⊘"
    \   },
    \ 'folder': {
    \   'arrow_open': "▾",
    \   'arrow_closed': "▸",
    \   'default': "▸",
    \   'open':  "▾",
    \   'empty': "▸",
    \   'empty_open': "▾",
    \   'symlink': "▸",
    \   'symlink_open': "▾",
    \   },
    \   'lsp': {
    \     'warning': "⊗",
    \     'error': "⊗",
    \   }
    \ }
