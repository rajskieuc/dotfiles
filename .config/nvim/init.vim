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
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set nohlsearch
set colorcolumn=100
set scrolloff=10
set signcolumn=yes
set termguicolors
set splitbelow
set splitright
set listchars=eol:¬,space:·
set list
""
" Plugins "
""
call plug#begin('~/.config/nvim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'pantharshit00/vim-prisma'
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'sjl/badwolf'
Plug 'ldelossa/vimdark'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'jparise/vim-graphql'
call plug#end()

""
" Theme settings "
""
let gruvbox_bold=1
let grubox_italic=1
set background=dark
colorscheme gruvbox
exe 'set background='. ((strftime('%H') % 24) > 9 ? 'dark' : 'light')
let gruvbox_contrast_dark='medium'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
let g:airline_symbols.dirty='!'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#dirty = '!'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
hi SpecialKey ctermfg=grey guifg=grey25
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber
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
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
"
""
" Key Mappings
""
let mapleader=" "
vnoremap <C-y> "*y
inoremap <C-a> <Esc>la
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-t> :tabnew<CR>
nnoremap <C-q> gT
nnoremap <C-e> gt
inoremap () ()<Esc>i
inoremap {} {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [] []<Esc>i
inoremap (<CR> (<CR>)<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap <> <><Esc>i
inoremap '' ''<Esc>i
inoremap "" ""<Esc>i
inoremap `` ``<Esc>i
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <F1> <nop>
vmap <leader>k  <Plug>(coc-format-selected)
nmap <leader>k  <Plug>(coc-format-selected)
nnoremap <leader>p <cmd>Telescope find_files<cr>
nnoremap <leader>f <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <leader>e :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>= :vertical resize +10<CR>
nnoremap <silent> <leader>- :vertical resize -10<CR>
lua << EOF
local dap_install = require("dap-install")
dap_install.config("chrome", {})


local dap = require("dap");
dap.configurations.typescriptreact = { -- change to typescript if needed
    {
        type = "chrome",
        request = "attach",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        port = 9222,
        webRoot = "${workspaceFolder}"
    }
}

require('dap.ext.vscode').load_launchjs()
EOF
