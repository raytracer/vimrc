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
Plug 'stevearc/dressing.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-jdtls'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tidalcycles/vim-tidal'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'shaunsingh/solarized.nvim'
Plug 'rmehri01/onenord.nvim', { 'branch': 'main' }
Plug 'mhartington/formatter.nvim'
"Syntax only
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
call plug#end()

let g:solarized_contrast = v:false
let g:solarized_borders = v:true

"colorscheme onenord
"set background=dark
set background=light
colorscheme solarized

"Nvim Tree
if !has("gui_vimr")
  lua require'nvim-tree'.setup{}

  nnoremap <C-e> :NvimTreeToggle<CR>
  nnoremap <C-f> :NvimTreeFindFile<CR>
endif


"Nvim Comp
set completeopt=menu,menuone,noselect

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        local col = vim.fn.col('.') - 1

        if cmp.visible() then
          cmp.select_next_item(select_opts)
        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          fallback()
        else
          cmp.complete()
          end
          end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item(select_opts)
        else
          fallback()
          end
          end, {'i', 's'}),
      },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    }, {
      { name = 'path' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['tsserver'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
  }
EOF

nnoremap <leader>r <Cmd>lua vim.lsp.buf.rename()<CR>

lua require'lspconfig'.rust_analyzer.setup({})

"tidalcycles
let g:tidal_target = "terminal"

"Nvim jdtls
nnoremap <leader><leader> <Cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap gd <Cmd>lua vim.lsp.buf.definition()<CR>
nnoremap K <Cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
nnoremap <F5> <Cmd>lua require('jdtls.dap').setup_dap_main_class_configs();require'dap'.continue()<CR>

"Nvim telescope 
nnoremap <C-p> <Cmd>Telescope find_files<cr>
nnoremap <leader>rr <Cmd>Telescope live_grep<cr>

"Lualine
lua require('lualine').setup( {options = {theme = 'solarized'}})
"lua require('lualine').setup({options = {theme = 'onenord'}})

" Gitsigns
lua require('gitsigns').setup()

" Dressing
lua require('dressing').setup()

if has('nvim-0.5')
  augroup lsp
    au!
    au FileType java lua require'jdtls_setup'.setup()
  augroup end
endif
