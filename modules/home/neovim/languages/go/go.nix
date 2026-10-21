{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.go;
in
{
  options.neovim.languages.go.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Go support (gopls, golangci-lint)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      go
    ];

    programs.neovim.extraPackages = with pkgs; [
      gopls
      golangci-lint
      golangci-lint-langserver
    ];

    neovim.treesitter.grammars = [
      "go"
      "gomod"
      "gosum"
      "gowork"
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./go.lua);
  };
}
