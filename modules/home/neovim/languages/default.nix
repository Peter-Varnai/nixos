{ lib, ... }:

{
  imports = [
    ./js-ts/js-ts.nix
    ./rust/rust.nix
    ./go/go.nix
    ./nix/nix.nix
    ./lua/lua.nix
    ./html-css/html-css.nix
    ./glsl/glsl.nix
  ];
}
