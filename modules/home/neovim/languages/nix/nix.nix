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
      nixfmt
    ];

    neovim.treesitter.grammars = [
      "tree-sitter-nix"
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./nix.lua);
  };
}
