" https://qiita.com/park-jh/items/b353319efb1823c36c05#yajsvimesnextsyntaxvimjavascript-libraries-syntax
augroup MyVimrc
  autocmd!
augroup END

if &compatible
  set nocompatible               " Be iMproved
endif

let $CACHE = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let $CONFIG = empty($XDG_CONFIG_HOME) ? expand('$HOME/.dein') : $XDG_CONFIG_HOME
let $DEIN = empty($XDG_DEIN_HOME) ? expand('$CACHE/dein') : $XDG_DEIN_HOME

" Required:
set runtimepath+=$DEIN/repos/github.com/Shougo/dein.vim
set clipboard+=unnamed

" 小文字だけの場合は療法、大文字検索は無視しない、という設定.など https://liginc.co.jp/409849
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split

" タブ幅の設定 https://liginc.co.jp/409849
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround
set number             "行番号を表示
set autoindent         "改行時に自動でインデントする

let g:indentLine_setConceal = 0

" undo
if has('persistent_undo')
  set undodir=$CACHE/.vim/undo
  set undofile
endif

" Required:
if dein#load_state(expand('$DEIN'))
  call dein#begin(expand('$DEIN'))

  " add plugin
  call dein#load_toml(expand('$CONFIG/plugins.toml'))
"  call dein#load_yaml(expand('$CONFIG/plugins.yaml'))
  call dein#load_toml(expand('$CONFIG/lazy.toml'))

  " Let dein manage dein
  " Required:
  call dein#add(expand('$DEIN/repos/github.com/Shougo/dein.vim'))

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
" syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" https://qiita.com/park-jh/items/b353319efb1823c36c05#yajsvimesnextsyntaxvimjavascript-libraries-syntax
function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction
autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()

colorscheme onedark
