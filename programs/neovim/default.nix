{ pkgs, use-two-trucs ? true, two-trucs, wit-nvim, ... }:

let
  two-trucs-bin = pkgs.rustPlatform.buildRustPackage rec {
    name = "two-trucs";
    version = "0.1.0";
    src = two-trucs;
    doCheck = false;
    cargoLock = {
      lockFile = "${src}/Cargo.lock";
    };
  };

  two-trucs-nvim-pkg = pkgs.vimUtils.buildVimPlugin {
    name = "two-trucs";
    version = "0.1.0";
    src = two-trucs;
    buildInputs = [ two-trucs-bin ];
    buildPhase = ''
      mkdir -p "$out/bin"

      ln -s "${two-trucs-bin}/bin/two-trucs" "$out/bin/two-trucs"
    '';
  };

  wit-nvim-pkg = pkgs.vimUtils.buildVimPlugin {
    name = "wit";
    version = "0.1.0";
    src = wit-nvim;
  };

  nvim-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.cpp
    p.lua
    p.markdown
    p.rust
    p.ruby
    p.typescript
    p.vim
  ]);

in

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    withRuby = false;
    withPython3 = false;

    plugins = [
      wit-nvim-pkg
      nvim-treesitter
      pkgs.vimPlugins.fzf-lua
      pkgs.vimPlugins.vim-fugitive
      pkgs.vimPlugins.nvim-surround
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.comment-nvim
      pkgs.vimPlugins.leap-nvim
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-vsnip
      pkgs.vimPlugins.vim-vsnip
      pkgs.vimPlugins.kanagawa-nvim
      pkgs.vimPlugins.lualine-nvim
    ] ++ (if use-two-trucs then [ two-trucs-nvim-pkg ] else []);

    initLua = ''
      require 'plugins'
      require 'autocommands'
      require 'settings'
      require 'mappings'
      require 'lsp'
    '';
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".vsnip".source = ./snippets;
  };
}
