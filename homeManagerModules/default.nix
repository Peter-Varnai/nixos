{ lib, ... }:
{
  imports = [
    ./alacritty/alacritty.nix
    # ./lf/lf.nix
    ./neovim/neovim.nix
    ./tmux/tmux.nix
  ];
}
