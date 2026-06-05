{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./../../homeManagerModules/default.nix
    # ./../stream_hub/stream_hub-user.nix
  ];

  # DECLARES A DIFFERENT TMUX SHORTCUT FOR REMOTE MACHINES
  programs.tmux.shortcut = "a";

  home = {
    username = "peter";
    homeDirectory = "/home/peter";
    packages = with pkgs; [
      brave
      blender
      vlc
      deluge
      discord
      spotify
      telegram-desktop
      lf
      neofetch

      # build tools / compilers
      clang
      rustup
      gnumake
      pkg-config
      nodejs_24

      # developing tools
      tree-sitter
      cargo-watch
      insomnia
      sqlite
      usql

      # system utilities
      nixos-anywhere
      zip

      # lsp
      nixd
      nixfmt-rfc-style
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint
      lua-language-server
      glsl_analyzer
      eslint
    ];

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      OPENAI_API_KEY = "$(cat /run/secrets/openai_api_key)";
    };

    stateVersion = "25.05";
  };

  programs = {
    starship.enable = true;

    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ta = "tmux attach -t";
      };
    };

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
