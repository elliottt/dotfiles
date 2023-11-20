# Dotfiles

## Setup

```shell
$ git clone ~/.dotfiles
$ mkdir -p ~/.config/home-manager
$ cd ~/.dotfiles
$ ln -s "hosts/$(hostname)".nix ~/.config/home-manager/home.nix
$ home-manager switch
```
