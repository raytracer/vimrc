"Key Bindings
let mapleader=" "
inoremap kj <Esc>
nnoremap j gj
nnoremap k gk

set clipboard+=unnamedplus
set clipboard+=unnamed
set background=light
set hidden
set nobackup
set nowritebackup
set number
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab
set termguicolors

"insert cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

call plug#begin('~/.config/nvim/plugged')
Plug 'hoob3rt/lualine.nvim'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/nvim-compe'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-jdtls'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'romainl/flattened'
Plug 'arcticicestudio/nord-vim'
"Syntax only
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'Omer/vim-sparql'
call plug#end()

"colorscheme nord
colorscheme flattened_light

"Nvim Tree
nnoremap <C-e> :NvimTreeToggle<CR>
nnoremap <C-f> :NvimTreeFindFile<CR>

"Nvim Compe
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

lua require'tab'

"Nvim jdtls
nnoremap <leader><leader> <Cmd>lua require('jdtls').code_action()<CR>
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <F5> <Cmd>lua require('jdtls.dap').setup_dap_main_class_configs();require'dap'.continue()<CR>

"Nvim telescope 
nnoremap <C-p> <Cmd>Telescope find_files<cr>
nnoremap <leader>rr <Cmd>Telescope live_grep<cr>

"Airline
lua require('lualine').setup({options = {theme = 'solarized_light'}})

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require'jdtls_setup'.setup()
  augroup end
endif
