" Vim
version 7.0 +autocmd +insert_expand +viminfo +langmap

if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

"Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
"NeoBundle 'Shougo/neosnippet.vim'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
"NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

NeoBundle 'ervandew/supertab'
NeoBundle 'vim-scripts/The-NERD-tree'
NeoBundle 'vim-scripts/Syntastic'
NeoBundle 'vim-scripts/Tagbar'
NeoBundle 'bling/vim-airline'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/vcscommand.vim'
NeoBundle 'vim-scripts/trailing-whitespace'
NeoBundle 'ctags.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


set nowrap
syntax on

set softtabstop=4 expandtab tabstop=4 shiftwidth=4


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"


set laststatus=2
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

let g:airline#extensions#tabline#enabled = 1
let g:airline_enable_syntastic=1
let g:airline_enable_tagbar=1

let g:airline_detect_modified=1
let g:airline_detect_paste=1

let g:syntastic_enable_signs=1

let g:airline_left_sep = '»'
let g:airline_right_sep = '«'

let g:airline_powerline_fonts=0

"set completeopt=menu,menuone,longest
set pumheight=15

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType='context'
let g:SuperTabContextDefaultCompletionType='<c-x><c-u>'

let g:clang_complete_auto = 1

" Show clang errors in the quickfix window
let g:clang_complete_copen = 1
"let g:clang_periodic_quickfix=1


"let g:clang_snippets = 0
"let g:clang_snippets_engine = 'snipmate'

colorscheme ron
set number
set hlsearch
set backspace=2
set noequalalways
set equalprg=
set gdefault
set hidden
set history=100
set incsearch
set isfname=@,48-57,/,.,-,_,+,,,$,:,~,{,}
set isprint=@,128-255
set noignorecase
set langmap=бA,вB,гC,дD,еE,жF,зG,иH,йI,кJ,лK,мL,нM,оN,пO,рP,сQ,тR,уS,фT,хU,цV,чW,шX,щY,ъZ,Бa,Вb,Гc,Дd,Еe,Жf,Зg,Иh,Йi,Кj,Лk,Мl,Нm,Оn,Пo,Рp,Сq,Тr,Уs,Фt,Хu,Цv,Чw,Шx,Щy,Ъz,Ы\[,ы\{,Э\],э\}
set laststatus=2
set scrolljump=0
set shelltype=4
set shiftround
set shiftwidth=4
set shortmess=mrntl
set sidescroll=1
set splitbelow
set nostartofline
set textwidth=0
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
set softtabstop=4 expandtab tabstop=4 shiftwidth=4

set whichwrap=<,>,[,]
set wrapmargin=0

set ruler
set ttyfast

set guifont=DejaVu\ Sans\ Mono\ 18

nnoremap <F5> :source ~/.vimrc<CR>

nnoremap <C-f> :tabnext<CR>
nnoremap <C-d> :tabprevious<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-k> :tabclose<CR>

nnoremap <C-l> :TagbarToggle<CR>
nnoremap <C-m> :marks<CR>
nnoremap <C-o> :NERDTreeToggle<CR>

nnoremap <C-p> :VCSVimDiff<CR>
