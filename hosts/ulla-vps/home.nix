{
  config,
  pkgs,
  inputs,
  ...
}:

{

  imports = [
    ./../../homeManagerModules/default.nix
  ];

  alacritty.enable = false;

  home.username = "peter";
  home.homeDirectory = "/home/peter";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    neofetch
    tree-sitter
    clang
    rustup
    cargo-watch
    zip
    gnumake
    pkg-config
    lf

    # lsp
    nixd
    nixfmt-rfc-style
    nodePackages.typescript-language-server
    nodePackages.typescript
    nodePackages.vscode-langservers-extracted
    lua-language-server
    glsl_analyzer
  ];

  programs = {
    starship.enable = true;

    bash.enable = true;

    git = {
      enable = true;
      userName = "Peter-Varnai";
      userEmail = "peter@varnai.dev";

      extraConfig = {
        credential.helper = "cache";
      };
    };

    home-manager.enable = true;
  };
}
