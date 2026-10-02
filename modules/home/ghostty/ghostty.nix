{ config, pkgs, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    # nixpkgs' source-built ghostty is Linux-only; use the official binary on macOS
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

    settings = lib.optionalAttrs pkgs.stdenv.isDarwin {
      # macOS: make Option act as Meta/Alt
      macos-option-as-alt = true;
      # Cmd+1 sends Meta-1 (ESC 1), so nvim sees <M-1>
      # Cmd+a sends Ctrl+a, the tmux prefix
      keybind = [
        "super+digit_1=esc:1"
        "super+a=text:\\x01"
      ];
    };
  };
}
