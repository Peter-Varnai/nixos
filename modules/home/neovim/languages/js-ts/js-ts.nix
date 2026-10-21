{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.neovim.languages.jsTs;
  pkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.hostPlatform) system; };
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
      pkgs-unstable.bun
    ];

    programs.neovim.extraPackages = with pkgs; [
      typescript-language-server
      typescript
      eslint
      vscode-langservers-extracted
    ];

    neovim.treesitter.grammars = [
      "javascript"
      "typescript"
      "tsx"
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./js-ts.lua);
  };
}
