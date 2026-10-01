{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.nix;
in
{
  options.neovim.languages.nix.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Nix support (nixd, nixfmt)";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];

    neovim.treesitter.grammars = [
      "tree-sitter-nix"
    ];

    programs.neovim.extraLuaConfig = lib.mkAfter (builtins.readFile ./nix.lua);
  };
}
