# mysetup
내가 쓰는 설정파일 모음
## How to Use
1. Install [vim-plug](https://github.com/junegunn/vim-plug)
2. Install [ruby](https://github.com/rbenv/rbenv)
3. Type this command in your terminal
```
$ chmod +x ./install
$ ./install
```
복원할때는
```
$ ./install restore
```

## 메모
* tmux, fzf, peco 설치
* ~/.config/tmuxinator에 파일 복사
* ~~vim-gtk를 설치해야지 "+y로 복사 가능 (neovim 받기 귀찮음)~~
* sudo update-alternatives --config editor -> neovim으로 바꾸기
* vi->neovim, vim->vim.nox로 alias하고 nvim으로는 coc.nvim, vim으로는 ycm 사용
* 저장소 미러서버 바꾸기
  ```
  apt서버
  $ sudo sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list # 한국
  $ sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list # 미국
  ```
