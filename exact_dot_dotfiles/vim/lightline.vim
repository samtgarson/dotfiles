" Hide the default statusbar because we have lightline
set noshowmode
set laststatus=2

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
\   'colorscheme': 'challenger_deep',
\   'active': {
\     'left': [ [ 'mode', 'paste' ],
\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
\     'right': [ [ 'lineinfo' ],
\                [ 'cocstatus', 'currentfunction', 'indicator' ] ]
\   },
\   'component_function': {
\     'cocstatus': 'coc#status',
\     'currentfunction': 'CocCurrentFunction',
\     'gitbranch': 'fugitive#head',
\     'indicator': 'LineNoIndicator'
\   },
\ }


