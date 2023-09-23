set nomodeline

execute pathogen#infect()
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

packloadall

colorscheme slate

hi Title ctermfg=White ctermbg=Black
hi TabLineFill ctermfg=Black ctermbg=White
hi TabLine ctermfg=Grey ctermbg=DarkGray
hi TabLineSel ctermfg=White ctermbg=DarkBlue

set ruler
set wildmenu
set cursorcolumn
"set cursorline

set statusline+=%F
set laststatus=2

syntax on
syntax enable

filetype plugin indent on

set list
set listchars=tab:>-

set paste
set number
set relativenumber
set mouse=a

set autoindent
set smartindent
set cindent

set guioptions+=a

set nofoldenable
set foldmethod=indent
set foldlevel=1
set foldclose=all

set expandtab
set tabstop=2
set shiftwidth=2

set incsearch
set ignorecase
set smartcase
set hlsearch

set omnifunc=syntaxcomplete#Complete

let g:rustfmt_autosave = 1

setlocal path=.,**
"setlocal path=.,src"
setlocal wildignore=*node_modules*

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
