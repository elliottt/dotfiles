{ ... }:

{

  programs.neovim = {
    enable = true;
  };

  home.file = {
    ".config/nvim".source = ./nvim;
    ".vsnip".source = ./snippets;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
