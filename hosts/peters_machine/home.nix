{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  programs.tmux.shortcut = "a";

  home = {
    username = "peter";
    homeDirectory = "/home/peter";

    packages = with pkgs; [
      brave
      blender
      vlc
      deluge
      discord
      spotify
      telegram-desktop
      lf
      fastfetch
      insomnia

      nixos-anywhere
      zip
    ];

    stateVersion = "25.05";
  };
}
