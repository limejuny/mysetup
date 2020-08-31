alias exp='explorer.exe .'
export EDITOR=/usr/bin/vi
function fcd {
  cd $(find $argv -type d | fzf)
}
