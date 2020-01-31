:set laststatus=2
:set colorcolumn=80
:set tabstop=4
:set shiftwidth=4
:colorscheme molokai
:set mouse=a
:set autoindent
:set number
:set wrap
:set nojoinspaces
":set cursorline
":set cursorcolumn

" Ultisnips options
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" youcompleteme options
"let g:ycm_collect_identifiers_from_tags_files = 1

" airline options
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Shortcuts
:map m :w<CR> :make!<CR>
":map s :w<CR>
":map q :wq<CR>

" Re-open a file at the last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif
endif

" Search tag file on parent directories, up to root
set tags=./tags;/
