" Vim
version 7.0 +autocmd +insert_expand +viminfo +langmap


set nowrap
syntax on

set nocompatible
filetype off
set softtabstop=4 expandtab tabstop=4 shiftwidth=4

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'SuperTab'
Bundle 'The-NERD-tree'
Bundle 'Syntastic'
Bundle 'Tagbar'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'mbbill/undotree'
Bundle 'vim-scripts/vcscommand.vim'
Bundle 'vim-scripts/trailing-whitespace'
Bundle 'ctags.vim'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_enable_syntastic=1
let g:airline_enable_tagbar=1

let g:airline_detect_modified=1
let g:airline_detect_paste=1

let g:syntastic_enable_signs=1

let g:airline_left_sep = '»'
let g:airline_right_sep = '«'

let g:airline_powerline_fonts=0


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

nnoremap <F5> :source ~/.vimrc<CR>

nnoremap <C-f> :tabnext<CR>
nnoremap <C-d> :tabprevious<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-k> :tabclose<CR>

nnoremap <C-l> :TagbarToggle<CR>
nnoremap <C-m> :marks<CR>
nnoremap <C-o> :NERDTreeToggle<CR>

nnoremap <C-p> :VCSVimDiff<CR>
