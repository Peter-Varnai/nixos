{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.wayland.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether the host runs a Wayland session (vs X11).";
  };

  config = {
    nixpkgs.config.allowUnfree = true;

    neovim.languages = {
      jsTs.enable = true;
      rust.enable = true;
      nix.enable = true;
      lua.enable = true;
      htmlCss.enable = true;
      glsl.enable = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
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
        settings = {
          user.name = "Peter-Varnai";
          user.email = "peter@varnai.dev";
          credential.helper = "cache";
        };
      };

      home-manager.enable = true;
    };
  };
}
