################# for fzf function ################
# ch - browse chrome history
ch() {
  local cols sep
  cols=$((COLUMNS / 3))
  sep='{::}'

  cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 1/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
    awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
    fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

ghq-repo-list-fzf-widget() {
  #local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}

zle -N ghq-repo-list-fzf-widget
bindkey '^]' ghq-repo-list-fzf-widget

get_starred_repos() {
  gh api user/starred --paginate --template '{{range .}}{{.html_url}}{{"\n"}}{{end}}'
}

ghq_get_starred-widget() {
  #local src=$(github-list-starred $(git config --global user.name) | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  local src=$(get_starred_repos | fzf)
  if [ -n "$src" ]; then
    BUFFER="ghq get $src" # 実行コマンドの格納
    zle accept-line       # 実行
  fi
  zle -R -c # クリア
}

zle -N ghq_get_starred-widget
bindkey '^\' ghq_get_starred-widget

get_owner_repos() {
  gh repo list -L 1000 --jq ".[].url" --json url
}

ghq_get_myrepos-widget() {
  local src=$(get_owner_repos | fzf)
  if [ -n "$src" ]; then
    BUFFER="ghq get $src" # 実行コマンドの格納
    zle accept-line       # 実行
  fi
  zle -R -c #クリア
}

zle -N ghq_get_myrepos-widget
bindkey '^{' ghq_get_myrepos-widget

subscripted-repo-fzf-widget() {

  local src=$(gh api --paginate user/subscriptions | jq -r '.[] | "\(.html_url)"' | sort | fzf)
  if [ -n "${src}" ]; then
    BUFFER="ghq get ${src}"
    zle accept-line
  fi
  zle -R -c
}

zle -N subscripted-repo-fzf-widget
bindkey '^:' subscripted-repo-fzf-widget
