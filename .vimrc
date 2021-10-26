set nomodeline

execute pathogen#infect()
autocmd vimenter * NERDTree
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-b> :NERDTreeToggle<CR>
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

colorscheme slate
hi Title ctermfg=White ctermbg=Black
hi TabLineFill ctermfg=Black ctermbg=White
hi TabLine ctermfg=Grey ctermbg=DarkGray
hi TabLineSel ctermfg=White ctermbg=DarkBlue

set ruler
syntax on

set list
set listchars=tab:>-

set tabstop=2

set paste
set autoindent
set number
set mouse=a

set incsearch
set ignorecase
set smartcase
set hlsearch

set omnifunc=syntaxcomplete#Complete
