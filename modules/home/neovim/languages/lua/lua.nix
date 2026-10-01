{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.lua;
in
{
  options.neovim.languages.lua.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Lua support (lua-language-server)";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      lua-language-server
    ];

    neovim.treesitter.grammars = [
      "tree-sitter-lua"
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./lua.lua);
  };
}
