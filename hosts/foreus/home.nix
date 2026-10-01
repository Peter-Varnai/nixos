{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  wireshark.enable = false;

  home = {
    username = "peter";
    homeDirectory = "/home/peter";

    packages = with pkgs; [
      lf
      neofetch
    ];

    stateVersion = "25.05";
  };
}
