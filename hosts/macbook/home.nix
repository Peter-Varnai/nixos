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
    homeDirectory = "/Users/peter";

    packages = with pkgs; [
      lf
      neofetch
      zip
    ];

    stateVersion = "25.05";
  };
}
