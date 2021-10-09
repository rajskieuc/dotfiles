syntax on
set nu rnu
set cursorline
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set hidden
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set nohlsearch
set colorcolumn=100
set scrolloff=8
set signcolumn=yes
set termguicolors
set splitbelow
set splitright

""
" Plugins "
""
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'puremourning/vimspector'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pantharshit00/vim-prisma'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'gruvbox-community/gruvbox'
Plug 'tomasiser/vim-code-dark'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jparise/vim-graphql'
call plug#end()

""
" FZF settings "
""
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg -g '!design/' -g '!dist/' -g '!pnpm-lock.yaml' -g '!.git' -g '!node_modules' -g '!build' --column --line-number --color=always --smart-case ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--exact --delimiter : --nth 4..'}), <bang>0)
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{build,.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

""
" Theme settings "
""
let gruvbox_bold=1
let grubox_italic=1
let gruvbox_contrast_dark='medium'
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

""
" Auto completion settings "
""
let g:coc_global_extensions = [
  \ 'coc-tsserver'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

""
" Key Mappings
""
let mapleader=" "
nnoremap <C-n> :NERDTree<CR>
nnoremap <leader>a :NERDTreeToggle<CR>
nnoremap <leader>t :tabnew<CR>
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>p :Files<CR>
nnoremap <leader>f :Rg <CR>
inoremap (~ ()<Esc>i
inoremap {~ {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [~ []<Esc>i
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR>] [<CR>]<Esc>O
inoremap <~ <><Esc>i
inoremap '~ ''<Esc>i
inoremap "~ ""<Esc>i
inoremap `~ ``<Esc>i
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <F1> <nop>
" Debugging
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>

nnoremap <leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>dT :call vimspector#ClearBreakpoints()<CR>

nmap <leader>dk <Plug>VimspectorRestart
nmap <leader>dh <Plug>VimspectorStepOut
nmap <leader>dl <Plug>VimspectorStepInto
nmap <leader>dj <Plug>VimspectorStepOver
