if &compatible
  set nocompatible
endif
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'

" file finder
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'rhysd/git-messenger.vim'
Plug 'rhysd/conflict-marker.vim'

" snippet
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

" ruby rails
Plug 'vim-ruby/vim-ruby'
Plug 'noprompt/vim-yardoc'
Plug 'tpope/vim-rails'
Plug 'slim-template/vim-slim'
Plug 'tomtom/tcomment_vim'

" markdown
Plug 'mattn/vim-maketable'

" html
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'

" vue
Plug 'posva/vim-vue'
Plug 'Shougo/context_filetype.vim'

" node
Plug 'moll/vim-node'
Plug 'mattn/jscomplete-vim'
Plug 'myhere/vim-nodejs-complete'
Plug 'pangloss/vim-javascript'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Fuzzy Finder
Plug 'mattn/vim-fz'

" ctags
Plug 'majutsushi/tagbar'
Plug 'pechorin/any-jump.vim'

" シンタックスチェック
Plug 'dense-analysis/ale'
Plug 'delphinus/lightline-delphinus'
Plug 'itchyny/lightline.vim'

" asyncomplete sources
Plug 'high-moctane/asyncomplete-nextword.vim'
Plug 'hotoolong/asyncomplete-tabnine.vim', { 'do': './install.sh' }
if executable('ctags')
  Plug 'prabirshrestha/asyncomplete-tags.vim'
endif

filetype plugin indent on
syntax enable

let mapleader = "\<Space>"

" Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'
Plug 'iberianpig/tig-explorer.vim'
Plug 'rbgrouleff/bclose.vim'

" fzf preview
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" colorscheme
Plug 'jacoborus/tender.vim'

" line number
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" operator and textobject oprator
Plug 'machakann/vim-sandwich'
Plug 'terryma/vim-expand-region'

" fish
Plug 'dag/vim-fish'

" reference
Plug 'rizzatti/dash.vim'
Plug 'thinca/vim-ref'

" etc
Plug 'thinca/vim-quickrun'
Plug 'lambdalisue/vim-quickrun-neovim-job'
Plug 'sheerun/vim-polyglot'
Plug 'hotoolong/translate.nvim'
Plug 'AndrewRadev/switch.vim'
Plug 'lambdalisue/pastefix.vim'
Plug 'simeji/winresizer'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Load Event
function! s:load_plug(timer)
    call plug#load(
                \ 'vim-ruby',
                \ 'vim-rails',
                \ 'vim-slim',
                \ 'tcomment_vim',
                \ )
endfunction

" Heavy plug-ins will be loaded later.
call timer_start(500, function("s:load_plug"))

filetype plugin indent on
syntax enable

let mapleader = "\<Space>"

" hotoolong/translate.nvim {{{
let g:translate_copy_result = 1
" }}}

" simeji/winresizer {{{
let g:winresizer_start_key = '<C-a>'
" }}}

" tpope/vim-fugitive {{{
autocmd BufWritePost *
      \ if exists('b:git_dir') && executable(b:git_dir.'/hooks/create_tags') |
      \   call system('"'.b:git_dir.'/hooks/create_ctags" &') |
      \ endif
" }}}

" prabirshrestha/asyncomplete-tags.vim {{{
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'whitelist': ['c'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))
" }}}

" AndrewRadev/switch.vim {{{
nnoremap <silent><C-c> :<C-u>Switch<CR>
autocmd FileType eruby let b:switch_custom_definitions =
    \ [
    \   {
    \     ':\(\k\+\)\s\+=>': '\1:',
    \     '\<\(\k\+\):':     ':\1 =>',
    \   },
    \ ]
" }}}

" yuki-ycino/fzf-preview.vim {{{
let g:fzf_preview_if_binary_command   = "test (file -b --mime-encoding {3}) = 'binary'"
let g:fzf_binary_preview_command      = 'echo "{3} is a binary file"'
let g:fzf_preview_git_files_command   = 'git ls-files --exclude-standard | while read line; do if [[ ! -L $line ]] && [[ -f $line ]]; then echo $line; fi; done'
let g:fzf_preview_grep_cmd            = 'rg --line-number --no-heading --color=never --sort=path'
let g:fzf_preview_mru_limit           = 500
let g:fzf_preview_use_dev_icons       = 1
let g:fzf_preview_default_fzf_options = {
\ '--reverse': v:true,
\ '--preview-window': 'wrap',
\ '--exact': v:true,
\ '--no-sort': v:true,
\ }

if !exists('g:fzf_preview_command')
  if executable('bat')
    let g:fzf_preview_command = 'bat --color=always --plain {-1}'
  else
    let g:fzf_preview_command = 'head -100 {-1}'
  endif
endif
let g:fzf_preview_git_status_preview_command = "test -z (git diff --cached -- {-1}) && git diff --cached --color=always -- {-1} || " .
\ "test -z (git diff -- {-1}) && git diff --color=always -- {-1} || " .
\ g:fzf_preview_command
let $FZF_PREVIEW_PREVIEW_BAT_THEME  = 'gruvbox'


noremap <fzf-p> <Nop>
map     ,    <fzf-p>

nnoremap <silent> <fzf-p>r     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> <fzf-p>w     :<C-u>CocCommand fzf-preview.ProjectMrwFiles<CR>
nnoremap <silent> <fzf-p>a     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
" nnoremap <silent> <fzf-p>g     :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> <fzf-p>s     :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> <fzf-p>b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> <fzf-p>B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> <fzf-p><C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> <fzf-p>/     :<C-u>CocCommand fzf-preview.Lines --resume --add-fzf-arg=--no-sort<CR>
" nnoremap <silent> <fzf-p>*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
" xnoremap <silent> <fzf-p>*     "sy:CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=substitute(@s, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
" nnoremap <silent> <fzf-p>n     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="<C-r>=substitute(@/, '\(^\\v\)\\|\\\(<\\|>\)', '', 'g')<CR>"<CR>
" nnoremap <silent> <fzf-p>?     :<C-u>CocCommand fzf-preview.BufferLines --resume --add-fzf-arg=--no-sort<CR>
" nnoremap          <fzf-p>f     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
" xnoremap          <fzf-p>f     "sy:CocCommand fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> <fzf-p>q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> <fzf-p>l     :<C-u>CocCommand fzf-preview.LocationList<CR>
nnoremap <silent> <fzf-p>:     :<C-u>CocCommand fzf-preview.CommandPalette<CR>
nnoremap <silent> <fzf-p>p     :<C-u>CocCommand fzf-preview.Yankround<CR>
nnoremap <silent> <fzf-p>m     :<C-u>CocCommand fzf-preview.Bookmarks --resume<CR>
" nnoremap <silent> <fzf-p><C-]> :<C-u>CocCommand fzf-preview.VistaCtags --add-fzf-arg=--query="<C-r>=expand('<cword>')<CR>"<CR>
nnoremap <silent> <fzf-p>o     :<C-u>CocCommand fzf-preview.VistaBufferCtags<CR>
" nnoremap <silent> <fzf-p>g     :<C-u>FzfPreviewProjectGrep --add-fzf-arg=--nth=3<Space>
" nnoremap <silent> <fzf-p>g     :<C-u>FzfPreviewProjectGrep . --resume<Space>
nnoremap <silent> <fzf-p>g     :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nnoremap <silent> <fzf-p>f     :<C-u>CocCommand fzf-preview.ProjectFiles<CR>

" nnoremap <silent> <dev>q  :<C-u>CocCommand fzf-preview.CocCurrentDiagnostics<CR>
" nnoremap <silent> <dev>Q  :<C-u>CocCommand fzf-preview.CocDiagnostics<CR>
" nnoremap <silent> <dev>rf :<C-u>CocCommand fzf-preview.CocReferences<CR>
" nnoremap <silent> <dev>t  :<C-u>CocCommand fzf-preview.CocTypeDefinitions<CR>

" AutoCmd User fzf_preview#initialized call s:fzf_preview_settings()

" function! s:buffers_delete_from_lines(lines) abort
"   for line in a:lines
"     let matches = matchlist(line, '\[\(\d\+\)\]')
"     if len(matches) >= 1
"       execute 'Bdelete! ' . matches[1]
"     endif
"   endfor
" endfunction

" function! s:fzf_preview_settings() abort
"   let g:fzf_preview_grep_preview_cmd = 'COLORTERM=truecolor ' . g:fzf_preview_grep_preview_cmd
"   let g:fzf_preview_command = 'COLORTERM=truecolor ' . g:fzf_preview_command
"
"   let g:fzf_preview_git_status_preview_command = " test (git diff --cached -- {-1}) != \"\" && git diff --cached --color=always -- {-1} || " .
"   \ "test (git diff -- {-1}) != \"\" && git diff --color=always -- {-1} || " .
"   \ g:fzf_preview_command
"
"   echo 'g:fzf_preview_git_status_preview_command'
"   echo g:fzf_preview_git_status_preview_command
"
"   let g:fzf_preview_custom_processes['open-file'] = fzf_preview#remote#process#get_default_processes('open-file', 'coc')
"   let g:fzf_preview_custom_processes['open-file']['ctrl-s'] = g:fzf_preview_custom_processes['open-file']['ctrl-x']
"   call remove(g:fzf_preview_custom_processes['open-file'], 'ctrl-x')
"
"   let g:fzf_preview_custom_processes['open-buffer'] = fzf_preview#remote#process#get_default_processes('open-buffer', 'coc')
"   let g:fzf_preview_custom_processes['open-buffer']['ctrl-s'] = g:fzf_preview_custom_processes['open-buffer']['ctrl-x']
"   call remove(g:fzf_preview_custom_processes['open-buffer'], 'ctrl-q')
"   let g:fzf_preview_custom_processes['open-buffer']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')
"
"   let g:fzf_preview_custom_processes['open-bufnr'] = fzf_preview#remote#process#get_default_processes('open-bufnr', 'coc')
"   let g:fzf_preview_custom_processes['open-bufnr']['ctrl-s'] = g:fzf_preview_custom_processes['open-bufnr']['ctrl-x']
"   call remove(g:fzf_preview_custom_processes['open-bufnr'], 'ctrl-q')
"   let g:fzf_preview_custom_processes['open-bufnr']['ctrl-x'] = get(function('s:buffers_delete_from_lines'), 'name')
"
"   let g:fzf_preview_custom_processes['git-status'] = fzf_preview#remote#process#get_default_processes('git-status', 'coc')
"   let g:fzf_preview_custom_processes['git-status']['ctrl-s'] = g:fzf_preview_custom_processes['git-status']['ctrl-x']
"   call remove(g:fzf_preview_custom_processes['git-status'], 'ctrl-x')
"
" endfunction

" }}}

" quickrun {{{
nnoremap \r :write<CR>:QuickRun<CR>

let g:quickrun_config = {'_': {}}

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

let g:quickrun_config['ruby.rspec'] = {
  \   'command': 'rspec',
  \   'cmdopt': '-f p',
  \   'exec': 'bundle exec %c %o %s',
  \   'filetype': 'rspec-result'
  \ }
let g:quickrun_config['rspec.line'] = {
  \   'command': 'rspec',
  \   'exec': 'bundle exec %c %s:%a',
  \   'filetype': 'rspec-result'
  \ }
function! s:RSpecQuickrun()
  set filetype=ruby.rspec
  let b:quickrun_config = { 'type': 'rspec' }
  nnoremap <silent> \t :write<CR>:execute 'QuickRun rspec.line -args ' . line('.')<CR>
endfunction
autocmd BufWinEnter,BufNewFile *_spec.rb call <SID>RSpecQuickrun()
" }}}

" hotoolong/asyncomplete-tabnine {{{
call asyncomplete#register_source(asyncomplete#sources#tabnine#get_source_options({
  \ 'name': 'tabnine',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#tabnine#completor'),
  \ 'config': {
  \   'line_limit': 1000,
  \   'max_num_result': 20,
  \  },
  \ })) 
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
 
let g:UltiSnipsEditSplit="vertical"
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
    \ 'name': 'ultisnips',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
    \ }))
" }}}

" dash.vim {{{
nmap <silent> <leader>d <Plug>DashSearch
" }}}

" vim-expand-region {{{
call expand_region#custom_text_objects('ruby', {
  \ 'im' :0,
  \ 'am' :0,
  \ })
" }}}

" vim-lsp {{{
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_text_edit_enabled = 0

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <f2> <plug>(lsp-rename)
  " refer to doc to add more commands
endfunction

augroup lsp_install
  au!
  " call s:on_lsp_buffer_enabled only for languages that has the server registered.
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
" }}}

" asyncomplete {{{
set completeopt=menuone,noselect,preview,noinsert
inoremap <expr><Tab>  pumvisible() ? "\<C-y>" : "\<Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 20

autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#ale#get_source_options({
\ 'priority': 10
\ }))

"  }}}

" high-moctane/asyncomplete-nextword.vim {{{
call asyncomplete#register_source(asyncomplete#sources#nextword#get_source_options({
  \   'name': 'nextword',
  \   'whitelist': ['*'],
  \   'args': ['-n', '20'],
  \   'completor': function('asyncomplete#sources#nextword#completor')
  \   }))
" }}}

" gitgutter {{{

" default ]c [c
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)
nmap <silent>,gr :<C-u>GitGutterUndoHunk<CR>
" }}}

" tagbar {{{
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

let g:tagbar_type_ruby = {
  \ 'kinds' : [
    \ 'm:modules',
    \ 'c:classes',
    \ 'd:describes',
    \ 'C:contexts',
    \ 'f:methods',
    \ 'F:singleton methods'
  \ ]
\ }
" }}}

" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
  \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
  \'active': {
  \  'left': [
  \    ['mode', 'paste'],
  \    ['readonly', 'filename', 'modified', 'ale'],
  \  ]
  \},
  \'component_function': {
  \  'filename': 'LightlineFilename',
  \  'ale': 'ALEGetStatusLine'
  \}
\ }

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:h') . '/' . expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

function! LightlineMode()
  return  &ft == 'denite' ? 'Denite' :
    \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" ale {{{
autocmd BufRead,BufNewFile *.slim setfiletype slim
let g:ale_linters = {
  \   'ruby': ['rubocop', 'reek', 'ruby', 'brakeman'],
  \   'slim': ['slimlint'],
  \   'markdown': ['textlint', 'markdownlint'],
  \   'text': ['textlint'],
  \}
let g:ale_completion_enabled = 1
let g:ale_ruby_rubocop_options = '--rails -c ./.rubocop.yml'
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" }}}

" tagbar {{{
nmap <silent><F4> :<C-u>TagbarToggle<CR>
let g:tagbar_autofocus = 1
" }}}

" jscomplete-vim {{{
autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
" }}}

" myhere/vim-nodejs-complete {{{
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'

let g:node_usejscomplete = 1
" }}}

" git-messenger {{{
let g:git_messenger_no_default_mappings = v:true
nmap ,gm <Plug>(git-messenger)
"}}}

" NERDTree {{{
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTab='<C-t>'
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 35
let NERDTreeAutoDeleteBuffer = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> td :<C-u>NERDTreeFind<CR>
" nnoremap <silent> <F3> :<C-u>NERDTreeToggle<CR>
" show hidden file
let NERDTreeShowHidden = 1
"nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}

" jistr/vim-nerdtree-tabs {{{
" デフォルトでツリーを表示させる
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_autofind=1
" }}}

set encoding=UTF-8
" default setting
nnoremap ; :
" nnoremap : ;
set sh=bash

set autoindent
set smartindent
set showmatch
set matchpairs+=<:>
set matchtime=1
set number relativenumber
"set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set list
set listchars=tab:->,trail:_
set ruler
set splitright
set backspace=indent,eol,start
" set ambiwidth=double " Unicodeで曖昧な文字2バイト表示
set textwidth=0      " 一行に長い文章を書いていても自動折り返しをしない
set display=lastline
set pumheight=10  "補完メニューの幅
set backupskip=/tmp/*,/private/tmp/*
set noswapfile
set expandtab
set tags+=.git/tags

" search {{{
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <silent><Esc><Esc> :nohlsearch<CR>
set modeline
set modelines=10
set inccommand=split
" }}}

" {{{
" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <C-y> <C-r>*
cnoremap <C-g> <C-c>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" terminal mode
tnoremap <silent> <ESC> <C-\><C-n>
tnoremap <silent> <C-s> <Nop>


set sidescroll=1
set ttimeoutlen=10
if has('persistent_undo')
  if !isdirectory($HOME.'/.vim/.undodir')
    call mkdir($HOME.'/.vim/.undodir', 'p', 0700)
  endif
  set undodir=~/.vim/.undodir
  set undofile
endif

" vimrc control {{{
nnoremap <silent><Space>. :<C-u>tabnew $MYVIMRC<CR>
nnoremap <silent><Space>s. :<C-u>source $MYVIMRC<CR>
" }}}

" bell {{{
" stop bell
set visualbell t_vb=
" }}}

nnoremap Y y$
nnoremap x "_x
nnoremap xp "0x"0p
nnoremap cw "_cw
nnoremap ce "_ce

" ビジュアルモード時vで行末まで選択
vnoremap v $h
" ビジュアルモードyank後最後の行に移動
vnoremap y y`>

" ddでレジスタを更新しても対応
noremap PP "0p

if has('mac')
  set clipboard+=unnamedplus
endif

" Tab
nnoremap t <Nop>
nnoremap <silent> tt :<C-u>tabnew<CR>:tabmove<CR>
" nnoremap <silent> td :<C-u>tabnew %:h<CR>
nnoremap <silent> tw :<C-u>tabclose<CR>
nnoremap <silent> tn :<C-u>tabnext<CR>
nnoremap <silent> tp :<C-u>tabprevious<CR>
" tag のリンクを tabで開く
" nnoremap <silent> <C-t><C-]> <C-w><C-]><C-w>T
nnoremap <silent> tj :<C-u>tab stjump <C-R>=expand('<cword>')<CR><CR>zz

" 日付追加
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M')

" filetype of ruby 
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby
autocmd BufNewFile,BufRead .pryrc     set filetype=ruby
autocmd FileType ruby setl iskeyword+=?

" sudo権限で保存
cnoremap w!! w !sudo tee > /dev/null %<CR>

augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile, BufRead *.tsv setlocal noexpandtab
augroup END

autocmd ColorScheme * highlight NormalFloat ctermbg=17 guibg=#374549
set termguicolors
colorscheme tender
