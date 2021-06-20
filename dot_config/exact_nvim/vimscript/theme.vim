if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Color theme settings
if (has("termguicolors"))
  set termguicolors
endif

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

syntax enable
set background=dark

let g:moonlight_italic_comments=1
let g:moonlight_italic_keywords=1
colorscheme moonlight

" Toggle line cursor on insert mode
autocmd InsertEnter,InsertLeave * set cul!

" Fill background with correct colour
" https://github.com/microsoft/terminal/issues/832#issuecomment-493747616
" set t_ut=""

