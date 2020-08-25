#!/bin/bash

function trycp() {
  src=$1
  dest=$2
  if [ "$3" == "uninstall" ] && [ ! -e "$src" ]; then
    printf '%s not exists.\n' "$src"
    return 1
  fi
  if [ ! -e "$dest" ]; then
    cp "$src" "$dest"
  elif cmp -s "$src" "$dest" ; then
    printf 'The file "%s" is the same as "%s".\n' "$src" "$dest"
  else
    if [ "$3" == "install" ]; then
      cp "$dest" "backup/$src"
    fi
    cp "$src" "$dest"
  fi
}

if [ "$1" == "install" ]; then
  if [ ! -d backup ]; then
    mkdir backup
  fi
  trycp vimrc ~/.vimrc install
  trycp ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py install
  gem install solargraph
  solargraph download-core
  echo ":CocInstall coc-metals"
elif [ "$1" == "uninstall" ]; then
  trycp ./backup/vimrc ~/.vimrc uninstall 
  trycp ./backup/ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py uninstall
else
  echo "usage: ./install.sh (install|uninsatll)"
fi
