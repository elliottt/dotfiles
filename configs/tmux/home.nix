{ ... }:

{

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
  };

  home.file = {
    ".tmux".source = ./tmux;
    ".tmux.conf".source = ./tmux.conf;
  };

}
