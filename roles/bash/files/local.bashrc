function fcd {
  cd $(find $argv -type d -not -path "**/node_modules/*" -not -path "**/.git/*" -not -path "**/venv/*"| fzf)
}

alias fd='fdfind'

alias ts='tmuxinator start'
alias te='tmuxinator edit'
alias tn='tmux new -s'
alias ta='tmux attach -t'

# {{{ fzf.git
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fco() {
  local tags branches target
  branches=$(
  git --no-pager branch --all \
    --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
      --ansi) || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      {}
FZF-EOF"
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "검색어를 입력해주세요."; return 1; fi
  rg --files-with-matches --no-messages $2 "$1" | fzf\
  --border\
  --height 80%\
  --extended\
  --ansi\
  --reverse\
  --cycle\
  --bind 'f1:execute(bat -f {})'\
  --bind 'alt-p:preview-up,alt-n:preview-down'\
  --bind 'ctrl-u:half-page-up,ctrl-d:half-page-down'\
  --bind '?:toggle-preview,alt-w:toggle-preview-wrap'\
  --bind 'alt-v:execute(vim {} >/dev/tty </dev/tty)'\
  --preview "cat {} | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}
# }}}

export PATH="$HOME/.local/bin:$HOME/.rbenv/shims:$HOME/go/bin:$HOME/.tfenv/bin:$HOME/.istioctl/bin:$HOME/.oci/bin:$PATH"
eval "$(rbenv init -)"

if [[ -v TMUX ]]; then
  unset HISTFILE
fi

source <(kubectl completion bash)
if command -v kubectl &> /dev/null; then
  alias k=kubectl
  complete -o default -F __start_kubectl k
fi

if command -v helm &> /dev/null; then
  eval "$(helm completion bash)"
fi

if command -v $HOME/bin/argocd &> /dev/null; then
  eval "$($HOME/bin/argocd completion bash)"
fi

# if command -v $HOME/.istioctl/bin/istioctl &> /dev/null; then
#   eval "$($HOME/.istioctl/bin/istioctl completion bash)"
# fi

export GIT_PS1_SHOWDIRTYSTATE=1
export PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;36m\]\$(__git_ps1)\[\033[0m\] \$ "

export ARGOCD_OPTS="--grpc-web"

alias us='unset HISTFILE'
