" Hide the default statusbar because we have lightline
set noshowmode
set laststatus=2

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
\   'colorscheme': 'nightowl',
\   'active': {
\     'right': [ [ 'lineinfo' ],
\                [ 'cocstatus', 'currentfunction', 'percent' ] ]
\   },
\   'component_function': {
\     'cocstatus': 'coc#status',
\     'currentfunction': 'CocCurrentFunction'
\   },
\ }


