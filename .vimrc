" Set compactibility to Vim only !
set nocompatible

" Show 80-column ruler
set colorcolumn=80
highlight ColorColumn ctermbg=236 guibg=#3a3a3a
set termguicolors

" Changed the leader to space ;) the backslash was incovienit
let mapleader=" "

" Wrap the text 
set wrap

" Encoding
set encoding=utf-8

syntax on
" Show Line Numbers
set number

" Status bar 
set laststatus=2


set autoindent
set smartindent
set tabstop=2
set shiftwidth=4
set expandtab " Use spaces instead of tabs

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
    source ~/.vimrc.plug
endif

" Clipboard redirect for yank commands :)
set clipboard=unnamedplus

" Set better colors for floating windows (CoC)
highlight Pmenu guibg=#1e1e1e guifg=#d4d4d4
highlight PmenuSel guibg=#264F78 guifg=#ffffff
highlight NormalFloat guibg=#1e1e1e guifg=#d4d4d4
highlight FloatBorder guibg=#1e1e1e guifg=#5c6370

" vim-gitgutter config
let g:gitgutter_enabled = 1
let g:gitgutter_highlight_lines = 1
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '_'
set updatetime=100
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1
" Soften GitGutter line highlights
highlight GitGutterAddLine    guibg=#e6fac3 guifg=NONE ctermbg=22 ctermfg=NONE
highlight GitGutterChangeLine guibg=#3e2e1e guifg=NONE ctermbg=52 ctermfg=NONE
highlight GitGutterDeleteLine guibg=#3f1e1e guifg=NONE ctermbg=52 ctermfg=NONE



" blamer-nvim : the git blame config
let g:blamer_enabled = 0                           " Start disabled (enable on-demand)
let g:blamer_delay = 700                           " Slightly longer delay (more stable)
let g:blamer_show_in_insert_modes = 0              " Don't show in insert mode
let g:blamer_show_in_visual_modes = 0              " Don't show in visual mode
let g:blamer_prefix = ' > '
highlight Blamer guifg=#888888 ctermfg=8
nnoremap <leader>bl :BlamerToggle<CR>               " On-demand toggle


function! GitGutterDiff()
  if exists('*GitGutterGetHunkSummary')
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
  endif
  return ''
endfunction



" branch name of current repo lol
let g:lightline = {
  \ 'colorscheme': 'everforest',
  \ 'active': {
  \   'left': [['mode', 'paste'], ['gitbranch', 'gitdiff', 'readonly', 'filename', 'modified']]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'gitdiff': 'GitGutterDiff'
  \ }
\ }


"let g:lightline.colorscheme = 'iceberg'

" Format selected code inline using clang-format
vnoremap <leader>f :!clang-format<CR>

" Keys for FZF Usage
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>h :History<CR>

" Colour Profiles for Vim :)
" Usage :call SetColorProfile('iceberg-light')
source ~/.vim/colors-profiles.vim
call SetColorProfile('everforest-dark') " set default here

" Shorcuts to change theme :)
nnoremap <leader>v1 :call SetColorProfile('everforest-light')<CR>
nnoremap <leader>v2 :call SetColorProfile('iceberg-light')<CR>
nnoremap <leader>v3 :call SetColorProfile('everforest-dark')<CR>
nnoremap <leader>v4 :call SetColorProfile('rosepine-moon')<CR>
nnoremap <leader>v5 :call SetColorProfile('peachpuff')<CR>
"nnoremap <leader>v5 :call SetColorProfile('nameincolourtheme.vim')<CR>

" Confirm coc.nvim suggestion with Enter key
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" Optional: Better tab navigation for coc popup
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Filesystem config

" Open fern in a vertical split with <leader>e
"nnoremap <silent> <leader>e :Fern . -drawer -width=25 -toggle<CR>
nnoremap <silent> <leader>e :call OpenFernDrawer()<CR>

" Use nerd font icons
let g:fern#renderer = 'nerdfont'

" Open Fern when Vim starts with a folder
let g:fern#default_hidden = 1         " Show hidden files
let g:fern#default_exclude = '\v(\.git|\.DS_Store|__pycache__)$'

" Hijack netrw
let g:fern#disable_default_mappings = 1

" fern mappings the file manager
function! s:fern_settings() abort
  nmap <buffer> <CR> <Plug>(fern-action-open:select)
  nmap <buffer> o <Plug>(fern-action-open:select)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
endfunction

augroup FernCustom
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

function! OpenFernDrawer()
  " If fern is not visible, open it with fixed width
  if !bufwinnr('fern://')
    execute 'Fern . -drawer -width=25 -toggle'
  else
    execute 'Fern . -reveal=% -drawer -width=25 -toggle'
  endif
endfunction




