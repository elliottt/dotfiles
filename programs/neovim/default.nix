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

in

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = [
      wit-nvim-pkg
      pkgs.vimPlugins.fzf-lua
      pkgs.vimPlugins.vim-repeat
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
      pkgs.vimPlugins.nvim-web-devicons
      pkgs.vimPlugins.tabline-nvim
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.mkdnflow-nvim
      pkgs.vimPlugins.dressing-nvim

      (pkgs.vimPlugins.nvim-treesitter.withPlugins (plugins: with plugins; [
        bash
        c
        cpp
        lua
        markdown
        rust
        typescript
        vim
      ]))
    ] ++ (if use-two-trucs then [ two-trucs-nvim-pkg ] else []);

    extraLuaConfig = ''

      require 'plugins'
      require 'autocommands'
      require 'settings'
      local mappings = require 'mappings'
      require 'lsp'.setup(mappings)
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
