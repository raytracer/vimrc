"Key Bindings
let mapleader=" "
inoremap kj <Esc>
nnoremap <C-p> :FZF<CR>
nnoremap j gj
nnoremap k gk
nmap <leader>e :CocCommand explorer<CR>
nmap <C-e> :CocCommand explorer<CR>
nmap <F1> :CocCommand java.debug.vimspector.start<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

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

"insert cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/flattened'
Plug 'puremourning/vimspector'
Plug 'skywind3000/vim-quickui'
Plug 'ChristianChiarulli/codi.vim'
"Syntax only
Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'Omer/vim-sparql'
call plug#end()

colorscheme flattened_light

"Airline
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

"Vim Quick-UI
let content = [
            \ [ 'Toggle Breakpoint', 'call vimspector#ToggleBreakpoint()' ],
            \ [ 'Toggle Condidtional Breakpoint', 'echo 200' ],
            \ [ 'Add Function Breakpoint', "call vimspector#AddFunctionBreakpoint('<cexpr>' )" ],
            \ [ '-' ],
            \ [ 'Go to Definition', "execute 'normal \<Plug>(coc-definition)'" ],
            \ [ 'Go to Type Definition', "execute 'normal \<Plug>(coc-type-definition)'" ],
            \ [ 'Refactor', "execute 'normal \<Plug>(coc-refactor)'" ],
            \]
let opts = {'title': 'select one'}

nmap <leader><leader> :call quickui#context#open(content, opts)<CR>

"Vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

"Completion Config
let g:coc_global_extensions = ['coc-tsserver', 'coc-java', 'coc-java-debug', 'coc-explorer']
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
