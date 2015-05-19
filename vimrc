" ========================================================================
" Vundle stuff
" ========================================================================
set nocompatible " Required by vundle
filetype off     " Required by vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'elixir-lang/vim-elixir'
Plugin 'ervandew/supertab'
Plugin 'koron/nyancat-vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-ruby/vim-ruby'
" Plugin 'wincent/Command-T'
Plugin 'scrooloose/nerdtree'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'kien/ctrlp.vim'
Plugin 'kongo2002/fsharp-vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'ngmy/vim-rubocop'
Plugin 'godlygeek/tabular'
" Ben Orenstein plugins
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'skwp/greplace.vim'
" Plugin 'tpope/vim-bundler'
" Plugin 'tpope/vim-cucumber'
" Plugin 'tpope/vim-dispatch'
" Plugin 'tpope/vim-endwise'
" Plugin 'tpope/vim-fugitive'
" Plugin 'tpope/vim-rails'
" Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'slim-template/vim-slim'
Plugin 'rizzatti/dash.vim'
" Plugin 'tpope/vim-unimpaired'

" nelstrom's plugin depends on kana's
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'

" UI Plugins
Plugin 'bling/vim-airline'       " UI statusbar niceties
  set laststatus=2               " enable airline even if no splits
  let g:airline_theme='luna'
  let g:airline_powerline_fonts=1
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_powerline_fonts = 1
  let g:airline_left_sep = ''
  let g:airline_right_sep = ''
  let g:airline_linecolumn_prefix = '␊ '
  let g:airline_linecolumn_prefix = '␤ '
  let g:airline_linecolumn_prefix = '¶ '
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = 'ρ'
  let g:airline_paste_symbol = 'Þ'
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0

" Ctrl-p configurations
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v(node_modules|bower_components|dist|deps|_build)'
  \ }
" Colors
Plugin 'nanotech/jellybeans.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Use the colorscheme from above
colorscheme jellybeans

" ========================================================================
" Settings (things with set)
" ========================================================================

set autoindent                  " autoindent on linebreak
set ts=2 sts=2 sw=2 expandtab   " Tab settings
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.
set history=500   " keep 500 lines of command line history
set showcmd		        " display incomplete commands
set ruler		        " show the cursor position all the time
set incsearch		        " do incremental searching
set nohlsearch                  " Stop highlihgt search after something -...
set backupdir=~/.tmp
set directory=~/.tmp
set timeoutlen=500 " Less leader timeout
set cc=80 " Display line at 80 chars

" Don't add the comment prefix when I hit enter or o/O on a comment line.
set formatoptions-=or
set wildignore+=*/tmp/*,*.so,*.swp,*.zip


" Readable highlight text
:highlight PmenuSel ctermfg=black

" Set gutter background to black
highlight SignColumn ctermbg=black

" Use Silver Searcher for 'grepping'
set grepprg=ag
let g:ackprg = 'ag --vimgrep'

set list listchars=tab:»·,trail:·
syntax on			" syntax highlighting

colorscheme jellybeans

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

" By default, vim thinks .md is Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Set FSharp Filetype
" au BufRead,BufNewFile *.fs set filetype=fs
" au BufRead,BufNewFile *.fsx set filetype=fs

" Read upon:
" Better? completion on command line
set wildmenu
" What to do when I press 'wildchar'. Worth tweaking to see what feels right.
set wildmode=list:full
set nowrap
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set autoread
set wmh=0
set viminfo+=!
set guioptions-=T
set guifont=Triskweline_10:h10
set et
set smarttab
set noincsearch
set ignorecase smartcase
set laststatus=2  " Always show status line.
set number
set gdefault " assume the /g flag on :s substitutions to replace all matches in a line
set autoindent " always set autoindenting on
set bg=light
set tags=./tags;
highlight StatusLine ctermfg=blue ctermbg=yellow
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
set nofoldenable " Say no to code folding...

" ========================================================================
" Mappings
" ========================================================================
let mapleader = ","

vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
map <Leader>bb :!bundle install<cr>
nmap <Leader>bi :source ~/.vimrc<cr>:PluginInstall<cr>
map <Leader>st :source %<cr>
map <Leader>sv :source .vimrc<CR>
map <Leader>d orequire 'pry'<cr>binding.pry<esc>:w<cr>
map <Leader>ra :%s/
map <Leader>rd :!bundle exec rspec % --format documentation<CR>
map <Leader>mt :!mix test %<CR>
map <Leader>rf :CommandTFlush<CR>:CommandT<CR>
map <Leader>rw :%s/\s\+$//<cr>:w<cr>
map <C-n> :NERDTreeToggle<cr>
" Edit another file in the same directory as the current file
" uses expression to extract path from current file's path
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>s :split <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>v :vnew <C-R>=escape(expand("%:p:h"), ' ') . '/'<CR>
map <Leader>c i_<Esc>r
map <Leader>stt :%retab!<Esc>

" Beginning and end of files as in terminal
imap <c-e> <c-o>$
imap <c-a> <c-o>^

" Rubocop
let g:vimrubocop_keymap = 0
map <Leader>rc :RuboCop<CR>

" Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:\zs<CR>
" vmap <Leader>a: :Tabularize /:\zs<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Strip Trailing Whitespaces (from VimCast.org)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

if has("autocmd")
    autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

" ========================================================================
" End of things set by me.
" ========================================================================

" ========================================================================
" Stuff from the vim example file
" ========================================================================

if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

endif " has("autocmd")
