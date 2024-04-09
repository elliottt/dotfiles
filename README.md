# Dotfiles

## Setup

```shell
$ git clone git@github.com:elliottt/dotfiles ~/.dotfiles
$ mkdir -p ~/.config/home-manager
$ cd ~/.dotfiles
$ ln -s "hosts/$(hostname)".nix ~/.config/home-manager/home.nix
$ home-manager switch
```
