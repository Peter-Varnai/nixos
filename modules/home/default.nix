{ lib, ... }:

{
  imports = [
    ./base.nix
    ./fonts.nix
    ./alacritty/alacritty.nix
    ./filezilla/filezilla.nix
    ./neovim/default.nix
    ./tmux/tmux.nix
    ./opencode/opencode.nix
    ./claude-code/claude-code.nix
    ./ghostty/ghostty.nix
    ./tooling/tooling.nix
    ./wireshark/wireshark.nix
  ];
}
