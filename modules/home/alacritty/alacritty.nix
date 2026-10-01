{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    alacritty.enable = lib.mkEnableOption "enables alacritty module";
  };

  config = {
    alacritty.enable = lib.mkDefault true;

    programs.alacritty = lib.mkIf config.alacritty.enable {
      enable = true;
      settings = {
        env = {
          TERM = "xterm-256color";
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
        font = {
          # normal.family = "JetBrainsMono Nerd Font Mono";
          size = 11.0;
        };
        # window.opacity = 0.95;
        colors.primary.background = "0x1E1E1E";
      };
    };

  };
}
