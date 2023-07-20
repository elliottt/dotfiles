{ ... }:

{

  programs.neovim = {
    enable = true;
  };

  home.file = {
    ".config/nvim".source = ./nvim;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
