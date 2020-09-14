# mysetup
내가 쓰는 설정파일 모음
## How to Use
1. Install [vim-plug](https://github.com/junegunn/vim-plug)
2. Install [ruby](https://rvm.io/rvm/install)
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
* vim-gtk를 설치해야지 "+y로 복사 가능 (neovim 받기 귀찮음)
* sudo update-alternatives --config editor -> vim으로 바꾸기
* 저장소 미러서버 바꾸기
  ```
  apt서버
  $ sudo sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list # 한국
  $ sudo sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list # 미국
  = = =
  pip서버
  $ echo "[global]
  index-url=http://mirror.kakao.com/pypi/simple
  trusted-host=mirror.kakao.com" > ~/.pip/pip.conf
  ```
