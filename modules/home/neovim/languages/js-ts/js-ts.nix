{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.jsTs;
in
{
  options.neovim.languages.jsTs.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "JavaScript/TypeScript support (ts_ls, eslint)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_24
    ];

    programs.neovim.extraPackages = with pkgs; [
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.eslint
    ];

    neovim.treesitter.grammars = [
      "javascript"
      "typescript"
      "tsx"
    ];

    programs.neovim.extraLuaConfig = lib.mkAfter (builtins.readFile ./js-ts.lua);
  };
}
