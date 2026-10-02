{ pkgs, ... }:

{
  # psql CLI client (ships with the postgresql package)
  home.packages = [ pkgs.postgresql ];
}
