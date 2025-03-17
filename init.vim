"Key Bindings
let mapleader=" "
inoremap kj <Esc>
nnoremap j gj
nnoremap k gk

set clipboard+=unnamedplus
set clipboard+=unnamed
set hidden
set nobackup
set nowritebackup
set number
set cursorline number
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab
set termguicolors
set mouse=a
set shell=/opt/homebrew/bin/fish

"insert cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

call plug#begin('~/.config/nvim/plugged')
Plug 'hoob3rt/lualine.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'saghen/blink.cmp'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'shaunsingh/solarized.nvim'
Plug 'mhartington/formatter.nvim'
"Syntax only
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
call plug#end()

let g:solarized_contrast = v:false
let g:solarized_borders = v:true

set background=light
colorscheme solarized

"Nvim Tree
if !has("gui_vimr")
  lua require'nvim-tree'.setup{}

  nnoremap <C-e> :NvimTreeToggle<CR>
  nnoremap <C-f> :NvimTreeFindFile<CR>
endif

"Nvim telescope 
nnoremap <C-p> <Cmd>Telescope find_files<cr>
nnoremap <leader>rr <Cmd>Telescope live_grep<cr>

"Lualine
lua require('lualine').setup( {options = {theme = 'solarized'}})

" Gitsigns
lua require('gitsigns').setup()
