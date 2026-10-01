{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.neovim.languages.rust;
in
{
  options.neovim.languages.rust.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Rust support (rust-analyzer)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      cargo-watch
      clang
      gnumake
      pkg-config
      cmake
    ];

    programs.neovim.extraPackages = with pkgs; [
      rust-analyzer
    ];

    neovim.treesitter.grammars = [
      "tree-sitter-rust"
    ];

    programs.neovim.extraLuaConfig = lib.mkAfter (builtins.readFile ./rust.lua);
  };
}
