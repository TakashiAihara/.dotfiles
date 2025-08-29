export PATH="/usr/local/sbin:$PATH"
export PATH="/root/.local/bin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export LANG=ja_JP.UTF-8

# zsh 保管機能有効
autoload -Uz compinit
compinit

##### history #####
setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
setopt HIST_NO_STORE              # histroyコマンドは記録しない
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS

HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000

# ディレクトリ解釈コマンドの自動移動
setopt AUTO_CD

# ディレクトリのスタック
setopt AUTO_PUSHD

# 重複排除
setopt PUSHD_IGNORE_DUPS

# 補完候補を一覧表示にする
setopt AUTO_LIST

# TAB で順に補完候補を切り替える
setopt AUTO_MENU

# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

# 補完候補の色づけ
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=13'

export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

export GHQ_ROOT=${HOME}/.ghq_src

export PATH="/root/.local/bin:$PATH"

export FLUTTER_ROOT="/root/.flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"
export PYTHONPATH=.

export GIT_EDITOR=nvim
