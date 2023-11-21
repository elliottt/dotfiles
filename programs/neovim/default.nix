{ ... }:

{

  programs.neovim = {
    enable = true;
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".vsnip".source = ./snippets;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
