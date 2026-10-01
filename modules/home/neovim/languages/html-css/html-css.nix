{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.htmlCss;
in
{
  options.neovim.languages.htmlCss.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "HTML/CSS/JSON support (vscode-langservers-extracted)";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      vscode-langservers-extracted
    ];

    neovim.treesitter.grammars = [
      "tree-sitter-json"
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./html-css.lua);
  };
}
