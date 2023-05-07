#        function _fzf_ghq_get_myrepos --description "ghq get for my repository"
#            set -l IFS
#            set selected_repository (
#              echo -e (
#                curl -s -u 'TakashiAihara' 'https://api.github.com/user/repos?type=private&per_page=100' | jq -r '.[].html_url'
#              )(
#                curl -s 'https://api.github.com/users/TakashiAihara/repos?per_page=100' | jq -r '.[].html_url'
#                ) | \
#                fzf --ansi \
#                    --tiebreak=index \
#                    --preview='git show --color=always {1}' \
#                    --query=(commandline --current-token)
#              )
#            if test $status -eq 0
#                ghq get $selected_repository
#            end
#            commandline --function repaint
#        end
#
#        ## function rprompt-git-current-branch {
#        ##   local branch_name st branch_status
#        ##
#        ##   if [ ! -e  ".git" ]; then
#        ##
#        ##     return
#        ##   fi
#        ##   branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
#        ##   st=`git status 2> /dev/null`
#        ##   if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#        ##
#        ##     branch_status="%F{green}"
#        ##   elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
#        ##
#        ##     branch_status="%F{red}?"
#        ##   elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
#        ##
#        ##     branch_status="%F{red}+"
#        ##   elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
#        ##
#        ##     branch_status="%F{yellow}!"
#        ##   elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
#        ##
#        ##     echo "%F{red}!(no branch)"
#        ##     return
#        ##   else
#        ##
#        ##     branch_status="%F{blue}"
#        ##   fi
#        ##
#        ##   echo "${branch_status}[$branch_name]"
#        ## }
#        ##
#        #set -x WORDCHARS '*?_-.[]~=&;!#$%^(){}<>'
#        #
#        #
#        #  set LOGDIR $HOME/term_logs
#        #  set LOGFILE (hostname)_(date +%Y-%m-%d_%H%M%S_%N.log)
#        #  [ ! -d $LOGDIR ] && mkdir -p $LOGDIR
#        #  tmux  set-option default-terminal "screen" \; \
#        #    pipe-pane        "cat >> $LOGDIR/$LOGFILE" \; \
#        #    display-message  "Started logging to $LOGDIR/$LOGFILE"
#
#        function gpall
#          git status
#          if test $status -ne 0
#            echo "current dir is not git repository."
#            return
#          end
#          for remote in (git branch -r)
#            git branch --track (echo $remote | sed "s;origin/;;g" | tr -d " ") (echo $remote | tr -d  " ")
#          end
#          git fetch --all
#          git pull --all
#        end
#        function freeze_without_version
#          pip freeze | sed "s/=.*//" | tee .requirements
#        end
#
#        ## [ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
#        #
#        ## load ubuntu, debian, centos
#        #[ -f /etc/os-release ] && . /etc/os-release && [ -f ~/.zshrc_${ID} ] && . ~/.zshrc_${ID}
#        ## load mac
#        #[ -f ~/.zshrc_`uname` ] && . ~/.zshrc_`uname`
#        #
#        #
#        ##function back_ghq_root() {
#        ##  for list in $(ghq list)
#        ##  do
#        ##	  if [ `echo $(dirname ${PWD})/$(basename ${PWD}) | grep "${list}/" | wc -l` -eq 1 ] ; then
#        ##		  echo $(ghq root)/${list}
#        ##		  cd $(ghq root)/${list}
#        ##    fi
#        ##}
#        #
#        ## for openssl
#        #function azw_max_wait(){
#        #  while true
#        #  do
#        #    echo `find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" | grep -v tmp | wc -l`
#        #    if [ `find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" | grep -v tmp | wc -l` -ge 10 ] ; then
#        #      alerter -message "waiting..."
#        #      find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" -exec calibredb add {} \;
#        #      alerter -message "imported"
#        #    fi
#        #    sleep 1
#        #  done
#        #}
#        #
#        #
#        #
#        #
#        #set -x ANDROID_SDK_ROOT "/usr/lib/androidsdk/"
#        #set -x PATH "/usr/lib/androidsdk:$PATH"
#        #set -x PATH "/usr/lib/androidsdk/tools:$PATH"
#        #set -x PATH "/usr/lib/androidsdk/tools/bin:$PATH"
#        #set -x PATH "/usr/lib/androidsdk/platform-tools-2:$PATH"
#        #set -x ANDROID_HOME "/usr/lib/Android"
#        #set -x PATH "$PATH:$ANDROID_HOME/tools"
#        #set -x PATH "$PATH:$ANDROID_HOME/platform-tools"
#        #
#        #set -x PATH "$PATH:/mnt/c/Windows/System32"
#        ##
#        #set -x PATH "$PATH:$HOME/$FLUTTER_SDK_PATH/.pub-cache/bin"
#        #set -x PATH "$PATH:./.fvm/flutter_sdk/bin"
#        #set -x PATH "/usr/local/sbin:$PATH"
#        #
#        #set -x PYENV_ROOT "$HOME/.pyenv"
#        #set -x PATH "$PYENV_ROOT/bin:$PATH"
#        #eval "$(pyenv init --path)"
#        #eval "$(pyenv init -)"
#        #
#        #set -x NVM_DIR "$HOME/.nvm"
#        #[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#        #
#        #eval "$(starship init zsh)"
#        #set -x PATH "/usr/local/opt/openjdk@8/bin:$PATH"
#        #
#        #alias grep='grep --exclude-dir node_modules --exclude-dir .git '
#        #
#        #set -x GOOGLE_APPLICATION_CREDENTIALS "/Users/takashi/.config/gcloud/mail-server-e42133a1ea90.json"
#        #
#        #function completely_uninstall_vscode(){
#        #  brew uninstall visual-studio-code visual-studio-code-insiders
#        #  rm -rf .vscode*
#        #  rm -rf ~/Library/Preferences/com.microsoft.VSCode*
#        #  rm -rf ~/Library/Caches/com.microsoft.VSCode*
#        #  rm -fr ~/Library/Application\ Support/Code*
#        #  rm -fr ~/Library/Saved\ Application\ State/com.microsoft.VSCode*
#        #}
#        #
#        #set -x VIMRUNTIME /usr/local/share/vim/vim82
#        #
#        #[ -f /usr/local/opt/dvm/dvm.sh ] && . /usr/local/opt/dvm/dvm.sh
#        #
#        #if [[ -f ~/.dvm/scripts/dvm ]]; then
#        #  . ~/.dvm/scripts/dvm
#        #fi
#        #
#        ##THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#        #function scrapyd_daemonstatus(){
#        #  curl http://$1:$2/daemonstatus.json
#        #}
#        #function scrapyd_addversion(){
#        #  curl http://$1:$2/addversion.json -F project=$3 -F version=$4 -F egg=@$5
#        #}
#        #function scrapyd_schedule(){
#        #  curl http://$1:$2/schedule.json -d project=$3 -d spider=$4
#        #  #curl http://$1:$2/schedule.json -d project=$3 -d spider=somespider -d setting=DOWNLOAD_DELAY=2 -d arg1=val1
#        #}
#        #function scrapyd_cancel(){
#        #  curl http://$1:$2/cancel.json -d project=$3 -d job=$4
#        #}
#        #function scrapyd_listprojects(){
#        #  curl http://$1:$2/listprojects.json
#        #}
#        #function scrapyd_listversions(){
#        #  curl "http://$1:$2/listversions.json?project=$3"
#        #}
#        #function scrapyd_listspiders(){
#        #  curl "http://$1:$2/listspiders.json?project=$3"
#        #}
#        #function scrapyd_listjobs(){
#        #  curl "http://$1:$2/listjobs.json?project=$3"
#        #}
#        #function scrapyd_delversion(){
#        #  curl http://$1:$2/delversion.json -d project=$3 -d version=$4
#        #}
#        #function scrapyd_delproject(){
#        #  curl http://$1:$2/delproject.json -d project=$3
#        #}
#        #
#        #function scrapyd-fzf() {
#        #  projects=$(scrapyd_listprojects $1 $2 | jq -r ".projects[]")
#        #  local project=$(echo -e "$projects"| fzf)
#        #  if [ -n "$project" ]; then
#        #    spiders=$(scrapyd_listspiders $1 $2 $project | jq -r ".spiders[]")
#        #    local spider=$(echo -e "$spiders"| fzf)
#        #    if [ -n "$spider" ]; then
#        #      scrapyd_schedule $1 $2 $project $spider
#        #    fi
#        #  fi
#        #}
#        #
#        #
#        #function get_mac_all_fonts() {
#        #osascript << SCPT
#        #use framework "AppKit"
#        #set fontFamilyNames to (current application's NSFontManager's sharedFontManager's availableFontFamilies) as list
#        #return fontFamilyNames
#        #SCPT
#        #}
#        #function git-dev-pull(){
#        #  git checkout develop ; git pull ; git checkout -
#        #}
#        #
#        function git_no_push
#          git remote set-url --push origin no_push
#        end
#
#        function git_yes_push
#          git remote set-url --delete --push origin no_push
#        end
#
#        function prdiff
#          # Identify the name of the source branch
#          set SRC_BRANCH (git show-branch | grep '*' | grep -v "(git rev-parse --abbrev-ref HEAD)" | head -1 | awk -F'[]~^[]' '{print $2}')
#
#          # Identify the hash of the branch point
#          set SRC_HASH (git show-branch --merge-base {$SRC_BRANCH} HEAD)
#
#          # Select file
#          set FILE (git diff --name-status {$SRC_HASH} HEAD | fzf | awk -F' ' '{print $2}')
#
#          # Show diff by the awesome tool
#          if [ -n "$FILE" ]; then
#            echo show diff $FILE
#            git difftool --no-prompt {$SRC_HASH}:{$FILE} HEAD:{$FILE}
#          end
#        end
#################### old zshrc
#
#
#       # TODO aliasは外だし
#       # install統合できるやつは外だし
#
#       #if [ $UID -eq 0 ];then
#       #PROMPT="%F{red}%n:%f%F{green}%d%f [%m] %%
#       #"
#       #else
#       #PROMPT="%F{cyan}%n:%f%F{green}%d%f [%m] %%
#       #"
#       #fi
#
#       # zplug
#       #export ZPLUG_HOME=$HOME/.zplug
#       #source $ZPLUG_HOME/init.zsh
#       #source $HOME/.zplugrc
#
#       # history
#       # http://blog.calcurio.com/zsh_hist.html
#       setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
#       setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
#       setopt HIST_NO_STORE              # histroyコマンドは記録しない
#
#       # https://qiita.com/syui/items/c1a1567b2b76051f50c4
#       setopt share_history
#       setopt hist_ignore_dups
#       setopt hist_save_no_dups
#
#       # HISTFILE=~/.zsh_history
#       HISTFILE=~/.zsh_history_$(hostname)
#
#       HISTSIZE=1000000
#       SAVEHIST=1000000
#
#       autoload -Uz compinit
#       compinit
#
#       bindkey -v
#
#       setopt AUTO_CD
#       setopt AUTO_PUSHD
#       setopt PUSHD_IGNORE_DUPS
#
#       # 補完候補を一覧表示にする
#       setopt auto_list
#       # TAB で順に補完候補を切り替える
#       setopt auto_menu
#       # 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
#       zstyle ':completion:*:default' menu select=1
#       # 補完候補の色づけ
#       export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#       zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#
#       # function rprompt-git-current-branch {
#       #   local branch_name st branch_status
#       #
#       #   if [ ! -e  ".git" ]; then
#       #
#       #     return
#       #   fi
#       #   branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
#       #   st=`git status 2> /dev/null`
#       #   if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
#       #
#       #     branch_status="%F{green}"
#       #   elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
#       #
#       #     branch_status="%F{red}?"
#       #   elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
#       #
#       #     branch_status="%F{red}+"
#       #   elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
#       #
#       #     branch_status="%F{yellow}!"
#       #   elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
#       #
#       #     echo "%F{red}!(no branch)"
#       #     return
#       #   else
#       #
#       #     branch_status="%F{blue}"
#       #   fi
#       #
#       #   echo "${branch_status}[$branch_name]"
#       # }
#       #
#       # setopt prompt_subst
#       #
#       # RPROMPT='`rprompt-git-current-branch`'
#
#       #export PATH="${PATH}:/usr/pgsql-10/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#
#       export LANG="ja_JP.UTF-8"
#       export LANGUAGE="ja_JP:ja"
#       export LC_ALL="ja_JP.UTF-8"
#
#       alias rails='bundle exec rails'
#       alias rake='bundle exec rake'
#       alias pumactl='bundle exec pumactl'
#       alias nv='nvim'
#       #alias s='rails s'
#       alias s='rails s -p 80 -b 0.0.0.0'
#       alias url_encode='nkf -WwMQ | tr = %'
#
#       bindkey -e
#
#       export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
#
#       [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
#       function my_routes() {
#         rails routes | \
#         grep $1 | \
#         sed \
#         -e 's/(\/:locale)//g' \
#         -e 's/(.:format)//g' \
#         -e 's/{:locale=>.*}//g' \
#         -e 's/URI Pattern/URI-Pattern/g' | \
#         awk -F'Verb|GET|POST|PUT|PATCH|DELETE' '{if(match($1, /^ *$/)){printf "\" %s\n", $0;} else print}' | \
#         awk '{printf "%-30s %-10s %-40s %-40s\n", $1,$2,$3,$4}'
#       }
#
#       alias rm='rm -i'
#       alias cp='cp -i'
#       alias mv='mv -i'
#
#       alias gpu='git push'
#       alias gco='git checkout'
#       alias gsh='git stash'
#       alias gst='git status'
#       alias gdi='git diff'
#       alias gbl='git blame'
#       alias gsb='git show-branch'
#
#
#
#       if [[ $TERM = screen ]] || [[ $TERM = screen-256color ]] ; then
#
#         LOGDIR=$HOME/term_logs
#         LOGFILE=$(hostname)_$(date +%Y-%m-%d_%H%M%S_%N.log)
#         [ ! -d $LOGDIR ] && mkdir -p $LOGDIR
#         tmux  set-option default-terminal "screen" \; \
#           pipe-pane        "cat >> $LOGDIR/$LOGFILE" \; \
#           display-message  "Started logging to $LOGDIR/$LOGFILE"
#       fi
#
#       export PATH=$PATH:$HOME/n/bin
#       alias edn='nv `npm prefix`/package.json'
#
#       [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
#
#       # add GO PATH
#       export GOPATH="$HOME/.go"
#       export PATH="$PATH:$(go env GOPATH)/bin"
#
#       function gpall() {
#         for remote in `git branch -r`; do git branch --track ${remote#origin/} $remote; done
#         git fetch --all
#         git pull --all
#       }
#
#       function freeze3_without_version(){
#         pip3 freeze | sed "s/=.*//" | tee .requirements
#       }
#
#       #function freeze_without_version(){
#         #pip freeze | sed "s/=.*//"
#       #}
#
#       # for npm local packages
#       export PATH=$PATH:./node_modules/.bin
#
#       ################# for fzf function ################
#       # fd - cd to selected directory
#       function fd() {
#         local dir
#         dir=$(find ${1:-.} -path '*/\.*' -prune \
#                         -o -type d -print 2> /dev/null | fzf +m) &&
#         cd "$dir"
#       }
#
#       # fh - search in your command history and execute selected command
#       function fh() {
#         eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
#       }
#
#       # ch - browse chrome history
#       function ch() {
#         local cols sep
#         cols=$(( COLUMNS / 3 ))
#         sep='{::}'
#
#         cp -f ~/Library/Application\ Support/Google/Chrome/Profile\ 1/History /tmp/h
#         sqlite3 -separator $sep /tmp/h \
#           "select substr(title, 1, $cols), url
#            from urls order by last_visit_time desc" |
#         awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
#         fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
#       }
#
#
#       function ghq-fzf-vscode() {
#         #local src=$(ghq list | fzf --preview "ls -laTp $(ghq root)/{} | tail -n+4 | awk '{print \$9\"/\"\$6\"/\"\$7 \" \" \$10}'")
#         local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
#         if [ -n "$src" ]; then
#           BUFFER="code $(ghq root)/$src" # 実行コマンドの格納
#           zle accept-line #実行
#         fi
#         zle -R -c #クリア
#       }
#
#       zle -N ghq-fzf-vscode
#       bindkey '^[' ghq-fzf-vscode
#

#       ### ghq function ###
#       function ghq-all-update() {
#         ghq list | ghq get -u -P
#       }
#
#       function ghq_import {
#         cat .ghq_list | ghq get
#       }
#
#       function ghq_importP {
#         cat .ghq_list | ghq get -P
#       }
#
#       function ghq_export {
#         ghq list > ~/.ghq_list
#       }
#
#       function ghq_export_add {
#         ghq list >> ~/.ghq_list
#       }
#
#       function docker_image_export(){
#         docker image list --format "table {{.Repository}}:{{.Tag}}" | grep -v "<none>" | tail +2 | tee ~/.docker_list
#       }
#
#       function docker_image_export_add(){
#         docker image list --format "table {{.Repository}}:{{.Tag}}" | grep -v "<none>" | tail +2 | tee -a ~/.docker_list
#       }

#       function convert_to_pem(){
#         # ssh-keygen -f $1 -e -m pem
#         openssl rsa -outform pem -in $1 -out $1.pem
#       }
#
#       # create an alias to run yadm for system files
#       alias syadm="sudo yadm -Y /etc/yadm"
#
#       # [ -f $ZDOTDIR/.zshrc_`uname` ] && . $ZDOTDIR/.zshrc_`uname`
#
#       export CARGO_HOME="$HOME/.cargo"
#       export PATH="$CARGO_HOME/bin:$PATH"
#
#       # load ubuntu, debian, centos
#       [ -f /etc/os-release ] && . /etc/os-release && [ -f ~/.zshrc_${ID} ] && . ~/.zshrc_${ID}
#       # load mac
#       [ -f ~/.zshrc_`uname` ] && . ~/.zshrc_`uname`
#
#       export PATH="$PATH:/mnt/c/Program Files/Docker/Docker/resources/bin:/mnt/c/ProgramData/DockerDesktop/version-bin"
#       export PATH="$PATH:/mnt/c/Windows"
#
#       #function back_ghq_root() {
#       #  for list in $(ghq list)
#       #  do
#       #	  if [ `echo $(dirname ${PWD})/$(basename ${PWD}) | grep "${list}/" | wc -l` -eq 1 ] ; then
#       #		  echo $(ghq root)/${list}
#       #		  cd $(ghq root)/${list}
#       #    fi
#       #}
#
#       function to_mkv(){
#         ffmpeg -loop 1 -framerate 1 -i $1 -i $2 -c:v libx264 -preset veryslow -crf 0 -c:a copy -shortest $3
#       }
#       function download_m3u8_to_mp4(){
#         ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -loglevel debug -i $1 -movflags faststart -c copy $2.mp4
#       }
#       export PATH="$PATH:/Users/takashi/Library/Android/sdk/platform-tools"
#
#       export ANDROID_SDK_ROOT="/Users/takashi/Library/Android/sdk"
#       export PATH="/Applications/calibre.app/Contents/MacOS:$PATH"
#       function azw_max_wait(){
#         while true
#         do
#           echo `find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" | grep -v tmp | wc -l`
#           if [ `find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" | grep -v tmp | wc -l` -ge 10 ] ; then
#             alerter -message "waiting..."
#             find "/Users/takashi/Library/Application Support/Kindle/My Kindle Content" -iname "*azw*" -exec calibredb add {} \;
#             alerter -message "imported"
#           fi
#           sleep 1
#         done
#       }
#
#       #  for puppeteer
#       export PATH=$PATH:/mnt/c/Program\ Files\ \(x86\)/Google/Chrome/Application
#       export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
#
#       # for wsl2 host resolve
#       export HOST_ADDRESS=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')
#
#       # for windows host resolve in wsl2
#       #export DOCKER_HOST="tcp://$HOST_ADDRESS:2376"
#
#       alias b='buku --suggest'
#       export PATH="$HOME/.rbenv/bin:$PATH"
#       eval "$(rbenv init -)"
#
#       export PATH="/mnt/c/Windows:$PATH"
#
#       export ANDROID_SDK_ROOT="/usr/lib/androidsdk/"
#       export PATH="/usr/lib/androidsdk:$PATH"
#       export PATH="/usr/lib/androidsdk/tools:$PATH"
#       export PATH="/usr/lib/androidsdk/tools/bin:$PATH"
#       export PATH="/usr/lib/androidsdk/platform-tools-2:$PATH"
#       export ANDROID_HOME="/usr/lib/Android"
#       export PATH="$PATH:$ANDROID_HOME/tools"
#       export PATH="$PATH:$ANDROID_HOME/platform-tools"
#
#       export PATH="$PATH:/mnt/c/Windows/System32"
#       #
#       # buku
#       export BUKU_PATH=".local/share/buku"
#       export BUKU_HOME="${HOME}/${BUKU_PATH}"
#
#       function bind_buku(){
#         sshfs root@aiharahome.asuscomm.com:/root/${BUKU_PATH} ${BUKU_HOME}
#       }
#
#       function unbind_buku(){
#         umount ${BUKU_HOME}
#       }
#
#       function snip_readme(){
#         curl -L https://gist.github.com/PurpleBooth/109311bb0361f32d87a2/raw/8254b53ab8dcb18afc64287aaddd9e5b6059f880/README-Template.md >> README.md
#       }
#
#       export PATH="$PATH:$HOME/$FLUTTER_SDK_PATH/.pub-cache/bin"
#       export PATH="$PATH:./.fvm/flutter_sdk/bin"
#       export PATH="/usr/local/sbin:$PATH"
#
#
#       export NVM_DIR="$HOME/.nvm"
#       [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#
#       eval "$(starship init zsh)"
#       export PATH="/usr/local/opt/openjdk@8/bin:$PATH"
#
#       alias grep='grep --exclude-dir node_modules --exclude-dir .git '
#
#       export GOOGLE_APPLICATION_CREDENTIALS="/Users/takashi/.config/gcloud/mail-server-e42133a1ea90.json"
#
#       function completely_uninstall_vscode(){
#         brew uninstall visual-studio-code visual-studio-code-insiders
#         rm -rf .vscode*
#         rm -rf ~/Library/Preferences/com.microsoft.VSCode*
#         rm -rf ~/Library/Caches/com.microsoft.VSCode*
#         rm -fr ~/Library/Application\ Support/Code*
#         rm -fr ~/Library/Saved\ Application\ State/com.microsoft.VSCode*
#       }
#
#       export VIMRUNTIME=/usr/local/share/vim/vim82
#
#       [ -f /usr/local/opt/dvm/dvm.sh ] && . /usr/local/opt/dvm/dvm.sh
#
#       if [[ -f ~/.dvm/scripts/dvm ]]; then
#         . ~/.dvm/scripts/dvm
#       fi
#
#       #export JAVA_HOME="/usr/lib/jvm/java-11-amazon-corretto/"
#       export PATH="/Users/takashi/fvm/default/bin:$PATH"
#
#       #export PATH="$HOME/.jenv/bin:$PATH"
#       #eval "$(jenv init -)"
#
#       #export JAVA_HOME=/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home
#       function scrapyd_daemonstatus(){
#         curl http://$1:$2/daemonstatus.json
#       }
#       function scrapyd_addversion(){
#         curl http://$1:$2/addversion.json -F project=$3 -F version=$4 -F egg=@$5
#       }
#       function scrapyd_schedule(){
#         curl http://$1:$2/schedule.json -d project=$3 -d spider=$4
#         #curl http://$1:$2/schedule.json -d project=$3 -d spider=somespider -d setting=DOWNLOAD_DELAY=2 -d arg1=val1
#       }
#       function scrapyd_cancel(){
#         curl http://$1:$2/cancel.json -d project=$3 -d job=$4
#       }
#       function scrapyd_listprojects(){
#         curl http://$1:$2/listprojects.json
#       }
#       function scrapyd_listversions(){
#         curl "http://$1:$2/listversions.json?project=$3"
#       }
#       function scrapyd_listspiders(){
#         curl "http://$1:$2/listspiders.json?project=$3"
#       }
#       function scrapyd_listjobs(){
#         curl "http://$1:$2/listjobs.json?project=$3"
#       }
#       function scrapyd_delversion(){
#         curl http://$1:$2/delversion.json -d project=$3 -d version=$4
#       }
#       function scrapyd_delproject(){
#         curl http://$1:$2/delproject.json -d project=$3
#       }
#
#       function scrapyd-fzf() {
#         projects=$(scrapyd_listprojects $1 $2 | jq -r ".projects[]")
#         local project=$(echo -e "$projects"| fzf)
#         if [ -n "$project" ]; then
#           spiders=$(scrapyd_listspiders $1 $2 $project | jq -r ".spiders[]")
#           local spider=$(echo -e "$spiders"| fzf)
#           if [ -n "$spider" ]; then
#             scrapyd_schedule $1 $2 $project $spider
#           fi
#         fi
#       }
#
#
#       function get_mac_all_fonts() {
#       osascript << SCPT
#       use framework "AppKit"
#       set fontFamilyNames to (current application's NSFontManager's sharedFontManager's availableFontFamilies) as list
#       return fontFamilyNames
#       SCPT
#       }
#
#       [[ -s "/$HOME/.gvm/scripts/gvm" ]] && source "/$HOME/.gvm/scripts/gvm"
#
#       # for fvm
#       export FVM_HOME="$HOME/.fvm"
#
#       # for yvm
#       export YVM_DIR="${HOME}/.yvm"
#       [ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
#       alias gggrep='ggrep -R -i --exclude .factorypath --exclude-dir "node_modules" --exclude-dir "target" --exclude-dir "designdocs" --exclude-dir "schema"'
#
#       alias ss='lsof -i -P | grep "LISTEN"'

#       function prdiff(){
#         git diff develop...$1
#       }
#
#       #function search-command(){
#         #compgen -c | grep $1 | grep -v "^_" | grep -v "zplug"
#       #}
#
#       function json-diff_(){
#         for jsonfile in `find improvement_second -type f | cut -d '/' -f 2-`
#           do echo json-diff $1/${jsonfile} $2/${jsonfile}
#           json-diff $1/${jsonfile} $2/${jsonfile}
#         done
#       }
#       [[ -e "/Users/takashi/lib/oci_autocomplete.sh" ]] && source "/Users/takashi/lib/oci_autocomplete.sh"
#
#       export PATH="$HOME/.brew/bin:$HOME/.brew/sbin:$PATH"
#
#
#       export YVM_DIR=/Users/takashi/.yvm
#
#

# vim-jetpack
# for vim
#[ ! -e ~/.vim/autoload/jetpack.vim ] && \
#curl -fLo ~/.vim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim

# for neovim
#[ ! -e ~/.config/nvim/autoload/jetpack.vim ] && \
#curl -fLo ~/.config/nvim/autoload/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/autoload/jetpack.vim
