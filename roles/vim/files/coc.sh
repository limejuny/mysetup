#!/bin/bash
vi +'CocInstall -sync coc-html coc-json coc-xml coc-yaml coc-sh coc-pyright coc-java coc-clangd coc-solargraph coc-tsserver coc-tabnine' +qall
mkdir -p ~/.config/coc/extensions/node_modules/coc-java/lombok
cp ~/bin/lombok/lombok.jar ~/.config/coc/extensions/node_modules/coc-java/lombok/lombok.jar
