{ lib, ... }:

{
  imports = [
    ./neovim.nix
    ./languages/default.nix
  ];
}
