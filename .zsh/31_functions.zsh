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

get-project-name() {
  dirname ${PWD} | rev | cut -d "/" -f 1 | rev
}

get-git-repository-name() {
  basename -s .git $(git config --get remote.origin.url)
}

get-repository-name() {
  basename ${PWD}
}

get-git-full-repo-name(){
  echo $(get-git-project-name)/$(get-git-repository-name)
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

get_all_subscriptions() {
  gh api --paginate user/subscriptions | jq -r '.[] | "\(.owner.login)/\(.name)"'
}

unwawtch_all_watched_repos() {
  for repo in $(get_all_subscriptions); do
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

git_flow_feature_start() {
  echo git flow feature start ${1}_#${2}
  git flow feature start ${1}_#${2}

  echo git flow feature publish
  git flow feature publish
}

git_flow_feature_finish_and_apply_main() {
  echo git flow feature finish
  git flow feature finish

  echo git pull
  git pull

  echo git push
  git push

  echo git checkout main
  git checkout main

  echo git pull
  git pull

  echo git merge origin/develop
  git merge origin/develop

  echo git push
  git push

  echo git switch develop
  git switch develop
}

update_all_workspaces() {
  for pac in $(find ${PWD} -type f -name "package.json" | grep -v node_modules); do
    cd $(dirname ${pac})
    pnpx npm-check-updates -u
  done
  cd $(git rev-parse --show-toplevel)
}

gh_issue_confirm() {
  branch=$(git rev-parse --abbrev-ref HEAD)
  issue_number=$(echo ${branch} | rev | cut -d "#" -f 1 | rev)
  gh issue view ${issue_number}
}

gic() {
  gh issue create --label $1 --body "" --title $2
}

create_labels(){
  gh label create "dev experience improvement"
  gh label create "ux improvement"
  gh label create "ui improvement"
  gh label create "ci/cd improvement"
  gh label create "security improvement"
  gh label create "wait"
}

gs() {
  gh issue create --label $1 --body "" --title $2
}

install-gh-star-quiet() {
  gh extension install maggie-j-liu/gh-star &> /dev/null
}

star-current-repo(){
  install-gh-star-quiet
  gh star $(get-git-full-repo-name)
}

unstar-current-repo(){
  install-gh-star-quiet
  gh star $(get-git-full-repo-name) -r
}

grc-current-repo(){
  gh repo create $(get-repository-name) --public
}

grcp-current-repo(){
  gh repo create $(get-repository-name) --private
}

grao-current-repo(){
  git remote add origin https://github.com/$(get-project-name)/$(get-repository-name).git
}
