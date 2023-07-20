{ ... }:

{

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    keyMode = "vi";
  };

  home.file = {
    ".tmux".source = ./tmux;
    ".tmux.conf".source = ./tmux.conf;
  };

}
