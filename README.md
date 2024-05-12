# Dotfiles

## Setup

```shell
$ git clone git@github.com:elliottt/dotfiles ~/.dotfiles
$ ~/.dotfiles/hm switch
```

NOTE: if the host config uses nixGL, `--impure` will need to be added to any
uses of the `hm` script.

## Adding a new host

Create a new config in the `hosts` directory, and add an entry in `flake.nix`.
