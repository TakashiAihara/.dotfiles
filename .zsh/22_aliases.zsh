alias pnpx='pnpm dlx'

alias dc='docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD:/$PWD" \
  -w="/$PWD" \
  docker/compose'

alias ldc='docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PWD:$PWD" \
  -w="$PWD" \
  lscr.io/linuxserver/docker-compose'

alias t2j='${HOME}/.ghq_src/github.com/TakashiAihara/markdown_table_conver_to_json/t2j.py'
