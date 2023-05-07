connect-vpn() {
  scutil --nc start $(scutil --nc list | grep L2TP | awk '{print $3}') --user takashi.aihara --password $(security find-generic-password -gw -a "takashi.aihara" "/Library/Keychains/System.keychain") --secret $(security find-generic-password -gw -a "" "/Library/Keychains/System.keychain")
}

disconnect-vpn() {
  scutil --nc stop $(scutil --nc list | grep L2TP | awk '{print $3}')
}

ghq-repository() {
  echo $(ghq root)/$(ghq list | grep $1)
}

reconnect-elecom-mouse() {
  blueutil --unpair c8-47-8c-1a-a0-80
  if [ $? -eq 0 ]; then
    echo disconnected
    echo sleep 5
    sleep 5
  fi
  blueutil --pair c8-47-8c-1a-a0-80
  if [ $? -eq 0 ]; then
    echo connected
  else
    echo error
  fi
}

reconnect-keyboard() {
  blueutil --unpair 00-18-a3-05-80-70
  if [ $? -eq 0 ]; then
    echo disconnected
    echo sleep 5
    sleep 5
  fi
  blueutil --pair 00-18-a3-05-80-70
  if [ $? -eq 0 ]; then
    echo connected
  else
    echo error
  fi
}

get-git-project-name() {
  dirname $(git config --get remote.origin.url) | rev | cut -d "/" -f 1 | rev
}

get-git-repository-name() {
  basename -s .git $(git config --get remote.origin.url)
}

get-git-bucket-compare-url() {
  echo $(get-git-source-url)"/compare/"$(get-git-repository-name)":develop..."$(get-git-repository-name)":"$(git symbolic-ref --short HEAD)
}

docker-image-export() {
  docker image list --format "table {{.Repository}}:{{.Tag}}" | grep -v "<none>" | tail +2 | tee ~/.docker_list
}

docker-image-export-add() {
  docker image list --format "table {{.Repository}}:{{.Tag}}" | grep -v "<none>" | tail +2 | tee -a ~/.docker_list
}

#### ghq function ###
ghq-all-update() {
  ghq list | ghq get -u -P
}

ghq-import() {
  cat .ghq_list | ghq get
}

ghq-importP() {
  cat .ghq_list | ghq get -P
}

ghq-set() {
  ghq list >~/.ghq_list
}

ghq-export-add() {
  ghq list >>~/.ghq_list
}

youtube-dl-wrap() {
  youtube-dl --no-check-certificate -o '%(title)s-%(id)s.%(ext)s' "$1"
}

apt-export() {
  mkdir -p ~/.apt/
  dpkg --get-selections >~/.apt/Package.list
  sudo cp -R /etc/apt/sources.list* ~/.apt/
  sudo apt-key exportall >~/.apt/Repo.keys
}

apt-import() {
  sudo apt-key add ~/.apt/Repo.keys
  sudo cp -R ~/.apt/sources.list* /etc/apt/
  sudo apt-get update
  sudo apt-get install dselect
  sudo dselect update
  sudo dpkg --set-selections <~/.apt/Package.list
  sudo apt-get dselect-upgrade -y
}

listprojects() {
  curl -u takashi:xcB2fB4tVfmanTFG http://aiharahome.ddns.net:6800/listprojects.json | jq -r ".projects[]"
}

listspiders() {
  curl -u takashi:xcB2fB4tVfmanTFG "http://aiharahome.ddns.net:6800/listspiders.json?project=amazon_kindle_it_books_scrape" | jq -r ".spiders[]"
}

gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/\$@; }

replace_ports() {
  find . -type d -name node_modules -prune -o -type d -name target -prune -o -type d -name .git -prune -o -print | xargs perl -i -pe "s/$1([^0-9a-zA-Z])/$2\$1/g"
  find . -type d -name node_modules -prune -o -type d -name target -prune -o -type d -name .git -prune -o -print | xargs perl -i -pe "s/$1\n/$2\n/g"
}

get_chromedriver() {
  curl https://raw.githubusercontent.com/TakashiAihara/open_functions/master/get_chromedriver.sh | sh
}

ggg() {
  if [ -n "$2" ]; then
    ghq get https://github.com/$1/$2.git
  elif [ -n "$1" ]; then
    ghq get https://github.com/TakashiAihara/$1.git
  fi
}

replace_github_url_to_raw() {
  echo "$1" | sed 's;github.com;raw.githubusercontent.com;' | sed 's;/blob/;/;'
}

unwawtch_all_watched_repos() {
  for repo in $(gh api --paginate user/subscriptions | jq -r '.[] | "\(.owner.login)/\(.name)"'); do
    gh api -X DELETE "/repos/${repo}/subscription"
  done
}

get_all_local_repos_path() {
  find ${GHQ_ROOT} -maxdepth 3 -mindepth 3 -type d
}

get_all_local_repos_signature() {
  get_all_local_repos_path | cut -d "/" -f 5-6
}

watch_all_local_repos() {
  for repo in $(get_all_local_repos_signature); do
    gh api -X PUT /repos/${repo}/subscription
    sleep 2
  done
}

remove_not_changed_all_local_repos() {
  for repo in $(get_all_local_repos_path); do
    echo $(echo ${repo} | cut -d "/" -f 5-6)
    count=$(git -C ${repo} ls-files --others --exclude-standard --modified --deleted | wc -l)
    echo "changed local file count -> $count"
    if [[ $count -eq 0 ]]; then
      rm -rf ${repo}
      echo "deleted"
    fi
    echo
  done
}

get_changed_files_count_from_ghq() {
  for repo in $(get_all_local_repos_path); do
    echo $(echo ${repo} | cut -d "/" -f 5-6)
    count=$(git -C ${repo} ls-files --others --exclude-standard --modified --deleted | wc -l)
    echo "changed local file count -> $count"
  done
}

get_changed_files_count() {
  for repo in $(find .ghq_src -maxdepth 3 -mindepth 3 -type d); do
    echo $(echo ${repo} | cut -d "/" -f 3-4)
    git -C ${repo} config core.filemode false
    count=$(git -C ${repo} ls-files --others --exclude-standard --modified --deleted | wc -l)
    echo "changed local file count -> $count"
  done
}

convert_to_pem() {
  ssh-keygen -f $1 -e -m pem
  openssl rsa -outform pem -in $1 -out $1.pem
}

camel_to_snake() {
  echo $1 | sed 's/^[[:upper:]]/\L&/;s/[[:upper:]]/\L_&/g'
}
