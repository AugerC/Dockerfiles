""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" DEPENDENCES
"" Colorscheme
" git clone https://github.com/lifepillar/vim-solarized8.git ~/.vim/pack/themes/opt/solarized8
"
"" COC
"       DEPENDENCES:
"               - sudo curl -sL install-node.now.sh/lts | bash
"               PYTHON: (https://github.com/neoclide/coc-python)
"                       - pip install jedi neovim pylint
"               JAVASCRIPT:
"                       - sudo npm install --global eslint prettier eslint-config-prettier eslint-plugin-prettier
"
"" Devicons -> Make this the last plugin (NOTE: Download is aprox 6.2GB)
"     git clone https://github.com/ryanoasis/nerd-fonts.git
"     cd nerd-fonts && ./install.sh UbuntuMono
"
"
"
"" coc config file (~/.config/nvim/coc-settings.json)
" :CocConfig
"
"{
"  "coc.preferences.formatOnSaveFiletypes": [
"    "css",
"    "markdown",
"    "javascript",
"    "graphql",
"    "html",
"    "json"
"  ],
"
"  "python.linting.enabled": true,
"  "python.linting.pylintEnabled": true,
"
"  "snippets.ultisnips.directories": ["UltiSnips", "~/.config/nvim/utils/snips"]
"}
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Basic
let mapleader = ","
"set background=dark

"Tells vim to not bother being vi
set nocompatible
set tabstop=2
set shiftwidth=2
set cmdheight=2
set mouse=a
set showcmd
set rnu
set nu
set cursorline
set scrolloff=7
set path+=**

filetype plugin on
syntax enable



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" REMAPPING

nmap <C-n> :NERDTreeToggle<CR>

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev X! x!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev X x
cnoreabbrev Q q
cnoreabbrev Qall qall


"" Optional + Recommended
" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Leader mappings
nnoremap <leader>d :bp<cr>:bd #<cr>
nmap <leader>; :bp<CR>
nmap <leader><leader> :bn<CR>


"" When on insert mode, tab inserts tabulations
vmap <Tab> >gv
vmap <S-Tab> <gv


"" Copy to system clipboard on wsl. Remove this if linux.
""````Needs`win32yank`->`https://github.com/equalsraf/win32yank/releases
let g:clipboard = {
			\   'name': 'wslclipboard',
			\   'copy': {
			\      '+': '/mnt/c/win32yank.exe -i --crlf',
			\      '*': '/mnt/c/win32yank.exe -i --crlf',
			\    },
			\   'paste': {
			\      '+': '/mnt/c/win32yank.exe -o --lf',
			\      '*': '/mnt/c/win32yank.exe -o --lf',
			\   },
			\   'cache_enabled': 1,
			\ }



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" PLUGINS
if empty(glob('.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
" Color schemes
Plug 'rafi/awesome-vim-colorschemes'
" Puppet syntax color
Plug 'rodjek/vim-puppet'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Fuzzy finder
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Nerdtree -> file manager
Plug 'preservim/nerdtree'
" Set a buffer list on the tabs
Plug 'ap/vim-buftabline'
" Surround
Plug 'tpope/vim-surround'

" COC - Needs node installed and a
"       DEPENDENCES:
"               - curl -sL install-node.now.sh/lts | bash
"               PYTHON: (https://github.com/neoclide/coc-python)
"                       - pip install jedi neovim pylint
"                       - :CocInstall coc-python
Plug 'neoclide/coc.nvim', {'branch': 'release'}



" Devicons -> Make this the last glugin
"   git clone https://github.com/ryanoasis/nerd-fonts.git
"   cd nerd-fonts && ./install.sh UbuntuMono
Plug 'ryanoasis/vim-devicons'
call plug#end()

colors PaperColor
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"" PLUGINS OPTIONS

" FZF
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
"" FZF Vin plugin maps
nmap <C-p> :FZF .<CR>
nmap <C-b> :Buffers<CR>
nmap <C-s> :Rg<CR>
" :Files [PATH]         Files (similar to :FZF)
" :GFiles [OPTS]        Git files (git ls-files)
" :GFiles?      Git files (git status)
" :Buffers      Open buffers
" :Colors       Color schemes
" :Ag [PATTERN]         ag search result (ALT-A to select all, ALT-D to deselect all)
" :Rg [PATTERN]         rg search result (ALT-A to select all, ALT-D to deselect all)
" :Lines [QUERY]        Lines in loaded buffers
" :BLines [QUERY]       Lines in the current buffer
" :Tags [QUERY]         Tags in the project (ctags -R)
" :BTags [QUERY]        Tags in the current buffer
" :Marks        Marks
" :Windows      Windows
" :Locate PATTERN       locate command output
" :History      v:oldfiles and open buffers
" :History:     Command history
" :History/     Search history
" :Snippets     Snippets (UltiSnips)
" :Commits      Git commits (requires fugitive.vim)
" :BCommits     Git commits for the current buffer
" :Commands     Commands
" :Maps         Normal mode mappings
" :Helptags     Help tags 1
" :FileFiles types      File types
"



" NERDTree
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" vim-airline
let g:airline_powerline_fonts = 1
let g:airline_theme='bubblegum'




" COC-nvim
let g:coc_global_extensions = [
	\ 'coc-snippets',
	\ 'coc-pairs',
	\ 'coc-python',
	\ 'coc-eslint',
	\ 'coc-prettier',
	\ 'coc-json',
	\ 'coc-rust-analyzer',
\]

"" From readme
" if hidden is not set, TextEdit might fail.
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

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

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"nmap <silent> <C-d> <Plug>(coc-range-select)
"xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
