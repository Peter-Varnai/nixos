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
      go.enable = true;
      nix.enable = true;
      lua.enable = true;
      htmlCss.enable = true;
      glsl.enable = true;
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    # Applied to every enabled shell (bash, zsh)
    home.shellAliases = {
      ta = "tmux attach -t";
    };

    programs = {
      starship.enable = true;

      # Ctrl-T files, Ctrl-R history, Alt-C cd
      fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      bash = {
        enable = true;
        enableCompletion = true;
      };

      git = {
        enable = true;
        settings = {
          user.name = "Peter-Varnai";
          user.email = lib.mkDefault "peter@varnai.dev";
          credential.helper = "cache";
        };
      };

      # Replaces `less` as git's pager: syntax highlighting, side-by-side, n/N to jump between files
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          navigate = true;
          side-by-side = true;
          line-numbers = true;
        };
      };

      home-manager.enable = true;
    };
  };
}
