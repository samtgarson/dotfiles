" Color theme settings
if (has("termguicolors"))
  set termguicolors
endif

syntax enable
let g:material_theme_style = 'lighter'
let g:material_terminal_italics = 1
colorscheme material

" Fill background with correct colour
" https://github.com/microsoft/terminal/issues/832#issuecomment-493747616
set t_ut=""

