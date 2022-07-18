<div align="center">
  

#  `rcwm (alpha)`

     Is in development, currently not working


<h3>
  Fast and practical X11 window manager, written in <code>nim👑</code>
  </h3>
<br>
</div align="center">
  
# Description ⚡️
`rcwm` is a fast and convenient window manager with two modes: tiling and floating. This window manager is positioned as wm without backward compatibility, that is, everything that our users find unnecessary we remove.
It has only the most necessary functions, everything else will be finished over time.

# Dependencies 🔍
`libx11` to work

`make` to build

# Dependencies install ⚙️
### to Arch based distro<img src="https://wiki.installgentoo.com/images/f/f9/Arch-linux-logo.png?raw=true" width="20px">
```fish
sudo pacman -Syu make libx11
```
### to Debian based distro<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Openlogo-debianV2.svg/1200px-Openlogo-debianV2.svg.png?raw=true" width="20px"> 
```fish
sudo apt install make libx11-dev 
```
### to Rpm based distro<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Fedora_logo.svg/1024px-Fedora_logo.svg.png?raw=true" width="20px">
```fish
sudo dnf install make libX11-devel
```
# Installation WM
```fish
git clone https://github.com/linuxxx0/rcwm
cd rcwm
sudo make clean install
vim .xinitrc >> exec rcwm
```
