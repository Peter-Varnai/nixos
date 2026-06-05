{ lib, ... }:

{
  imports = [
    ./alacritty/alacritty.nix
    ./filezilla/filezilla.nix
    ./neovim/neovim.nix
    ./tmux/tmux.nix
    ./opencode/opencode.nix
    ./ghostty/ghostty.nix
  ];
}
