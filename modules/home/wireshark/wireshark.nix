{
  config,
  pkgs,
  lib,
  ...
}:

{
  options = {
    wireshark.enable = lib.mkEnableOption "enables the wireshark module";
  };

  config = {
    wireshark.enable = lib.mkDefault false;

    home.packages = lib.mkIf config.wireshark.enable (with pkgs; [
      wireshark
    ]);
  };
}
