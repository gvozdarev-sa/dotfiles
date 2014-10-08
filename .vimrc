version 7.0 +autocmd +insert_expand +viminfo +langmap

" Remove ALL autocommands to prevent them from being loaded twice.
if has("autocmd")
  autocmd!
endif

" We love syntax highlighting.
if has('syntax')
  syntax on
endif

" Options
"-----------------------------------------------------------------------------
" See `:h options` for more help.
set nocompatible                 " The most important VIM option
scriptencoding utf-8
set modelines=5                  " The Vim that comes with OS X changed the default value for some reason. Setting it back.

set smarttab
set softtabstop=4 expandtab tabstop=4 shiftwidth=4                    " set the default tabstops
set shiftwidth=4                 " set the default autoindent
set softtabstop=4
set expandtab
set hidden

set autoindent
set shiftround                   " Round indents to a multiple of 'shiftwidth'
"set complete-=i                  " Don't scan includes, since it can be very slow.
set backspace=indent,eol,start   " Set for maximum backspace smartness

set nowrap                       " Soft (without changing text) wrapping.
set linebreak                    " Only wrap on characters in `breakat`
if has('multi_byte')
  let &showbreak = '↳ '
else
  let &showbreak = '> '
endif

set ignorecase                   " ignore case in searches ... (\c\C override)
set smartcase                    " ... unless there are caps in the search
set incsearch                    " If the terminal is slow, turn this off



set hlsearch
set backspace=2
set noequalalways
set equalprg=
set gdefault
set history=100
set incsearch
set isfname=@,48-57,/,.,-,_,+,,,$,:,~,{,}
set isprint=@,128-255
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
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
set wrapmargin=0
set number

set ruler
set ttyfast

set guifont=DejaVu\ Sans\ Mono\ 18

if has('vim_starting')
    set nocompatible               " Be iMproved

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundle 'mhinz/vim-startify'             " Nice start screen
let g:startify_bookmarks = ['~/.vimrc',]
let g:startify_change_to_dir = 0
let g:startify_files_number = 8
let g:startify_skiplist = ['vimrc',]

NeoBundle 'airblade/vim-rooter'
let g:rooter_patterns = ['tags', '.git', '.git/']


"Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

if has("lua") && (v:version > 703 || (v:version == 703 && has("patch885")))
    " Use NeoComplete
    " ---------------
    let g:neocomplete#enable_at_startup              = 1
"    let g:neocomplete#force_overwrite_completefunc   = 1
    let g:neocomplete#data_directory                 = '~/.vim/neocomplcache'

    let g:neocomplete#auto_completion_start_length   = 1
    let g:neocomplete#manual_completion_start_length = 0
    let g:neocomplete#min_keyword_length             = 1
    let g:neocomplete#enable_auto_close_preview      = 1

    let g:neocomplete#keyword_patterns      = {}
    let g:neocomplete#keyword_patterns._    = '\h\w*'

    let g:neocomplete#sources#omni#input_patterns      = {}
    let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.c    = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplete#sources#omni#input_patterns.cpp  = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    let g:neocomplete#force_omni_input_patterns      = {}
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'

    let g:neocomplete#same_filetypes           = {}
    let g:neocomplete#same_filetypes.gitconfig = '_'
    let g:neocomplete#same_filetypes._         = '_'

    " For perlomni.vim setting.
    NeoBundle "c9s/perlomni.vim"

    if !exists('g:neocomplete#sources#file_include#exprs')
        let g:neocomplete#sources#file_include#exprs = {}
	endif
	let g:neocomplete#sources#file_include#exprs.perl = 'fnamemodify(substitute(v:fname, "/", "::", "g"), ":r")'
"    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\|\h\w*->\h\w*\|\h\w*::\|\h\w*::\h\w*'

    let g:neocomplete#ctags_arguments = {
            \ 'perl': '-R -h ".pm"'
            \ }

"    let g:neocomplete#sources#dictionary#dictionaries = {
"            \ 'default': '',
"            \ 'perl': g:home . '/.vim/dict/perl.dict'
"            \ }

    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
    endfunction

    NeoBundle 'Shougo/neocomplete'
"    NeoBundle 'Shougo/neosnippet'
"    NeoBundle 'Shougo/neosnippet-snippets'

    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
else
    " SuperTab option for context aware completion
    let g:SuperTabDefaultCompletionType='<c-x><c-o>'
    let g:SuperTabContextDefaultCompletionType='<c-x><c-u>'

    NeoBundle 'ervandew/supertab'
endif
" Syntax checking
if exists('*getmatches')
    NeoBundle 'scrooloose/syntastic'
    let g:syntastic_enable_signs=1
    let g:syntastic_error_symbol          = '✗✗'
    let g:syntastic_warning_symbol        = '⚠⚠'
    let g:syntastic_style_error_symbol    = '✗'
    let g:syntastic_style_warning_symbol  = '⚠'
    let g:syntastic_auto_loc_list         = 1 " Close the location-list when errors are gone
    let g:syntastic_loc_list_height       = 5
    let g:syntastic_sh_checkers           = ['shellcheck', 'checkbashisms', 'sh']
    let g:syntastic_sh_checkbashisms_args = '-x'
    let g:syntastic_ruby_checkers         = ['mri', 'jruby', 'rubocop']
    let g:syntastic_ruby_rubocop_args     = '--display-cop-names'
    let g:syntastic_scss_checkers         = ['sass']
    let g:syntastic_sass_checkers         = ['sass']
    let g:syntastic_xml_checkers          = ['xmllint']
    let g:syntastic_xslt_checkers         = ['xmllint']
    let g:syntastic_enable_perl_checker = 1
    let g:syntastic_perl_checkers         = ['perl']
    " npm install js-yaml
    let g:syntastic_yaml_checkers         = ['jsyaml']
    NeoBundle 'dbakker/vim-lint'
endif

NeoBundle 'vim-scripts/The-NERD-tree'
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



" Display an indent line
NeoBundle 'Yggdroot/indentLine'
let g:indentLine_char = "│"
let g:indentLine_noConcealCursor = 1

" The only theme worth knowing.
NeoBundle 'altercation/vim-colors-solarized'
set background=dark 
let g:solarized_termcolors=256
colorscheme solarized

if v:version >= 702
    NeoBundle 'bling/vim-airline'
    
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    
    let g:airline_symbols.space = "\ua0"
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_enable_syntastic=1
    let g:airline_enable_tagbar=1

    let g:airline_detect_modified=1
    let g:airline_detect_paste=1

    let g:airline_left_sep = '»'
    let g:airline_right_sep = '«'

    let g:airline_powerline_fonts=0

    set noshowmode
endif

" JSON & JS
NeoBundle 'elzr/vim-json'
NeoBundle 'pangloss/vim-javascript'

" In many terminal emulators the mouse works just fine, thus enable it.
if v:version >= 702 && has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    set ttymouse=xterm2
  endif
endif

" Omnicompletion
"-----------------------------------------------------------------------------

set completeopt=menu,longest
set omnifunc=syntaxcomplete#Complete " This is overriden by syntax plugins.


if has('autocmd')
  autocmd FileType python        nested setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby,eruby    nested setlocal omnifunc=rubycomplete#Complete
  autocmd FileType css           nested setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown nested setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript    nested setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml           nested setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType pl            nested setlocal omnifunc=perlcomplete#OmniPerl_Complete
endif

nnoremap <F5> :source ~/.vimrc<CR>

nnoremap <C-f> :tabnext<CR>
nnoremap <C-d> :tabprevious<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-k> :tabclose<CR>

nnoremap <C-l> :TagbarToggle<CR>
nnoremap <C-m> :marks<CR>
nnoremap <C-o> :NERDTreeToggle<CR>

nnoremap <C-p> :VCSVimDiff<CR>

set whichwrap+=<,>,h,l,[,]

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Local vimrc settings
"-----------------------------------------------------------------------------
" If the file ~/.vimrc.local exists, then it will be loaded as well.

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

set secure
" EOF
