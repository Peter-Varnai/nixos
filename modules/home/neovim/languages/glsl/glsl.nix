{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.glsl;
in
{
  options.neovim.languages.glsl.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "GLSL shader support (glsl_analyzer)";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      glsl_analyzer
    ];

    programs.neovim.initLua = lib.mkAfter (builtins.readFile ./glsl.lua);
  };
}
