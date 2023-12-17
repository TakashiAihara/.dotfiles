if [ -e /usr/local/opt/zinit/zinit.zsh ] ; then
  source /usr/local/opt/zinit/zinit.zsh
else
  ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
  source "${ZINIT_HOME}/zinit.zsh"
fi

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-bin-gem-node
### End of Zinit's installer chunk
#

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit load zdharma-continuum/history-search-multi-word

zinit ice from"gh-r" as"program"
# zinit load junegunn/fzf

zinit wait lucid atload"zicompinit; zicdreplay" blockf for zsh-users/zsh-completions

zinit ice as"program" atclone"rm -f src/auto/config.cache; ./configure" \
    atpull"%atclone" make pick"src/vim"
zinit light vim/vim

zinit ice as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX"
zinit light tj/git-extras

# TODO impl for windows
#zinit light TakashiAihara/zsh-notify

zinit light ajeetdsouza/zoxide

zinit light StackExchange/blackbox
zstyle ':notify:*' command-complete-timeout 15
zstyle ':notify:*' always-notify-on-failure no

zinit light wfxr/forgit

# クローンしたGit作業ディレクトリで、コマンド `git open` を実行するとブラウザでGitHubが開く
zinit light paulirish/git-open

# jq をインタラクティブに使える。JSONを標準出力に出すコマンドを入力した状態で `Alt+j` すると jq のクエリが書ける。
# 要 jq
zinit light reegnz/jq-zsh-plugin

# Gitの変更状態がわかる ls。ls の代わりにコマンド `k` を実行するだけ。
zinit light supercrabtree/k

# for zsh_history sync
zinit snippet https://github.com/wulfgarpro/history-sync/blob/master/history-sync.plugin.zsh

# aws cli & aws local cli
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
complete -C '/usr/local/bin/aws_completer' awslocal
complete -o nospace -C '/root/.tfenv/bin/terraform' terraform
zinit light drgr33n/oh-my-zsh_aws2-plugin

# autoload -U +X bashcompinit && bashcompinit

