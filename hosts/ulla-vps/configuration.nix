{
  modulesPath,
  lib,
  pkgs,
  ...
}@args:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
    ./../../system_packages/nginx/nginx.nix
    ./backend_service.nix
  ];

  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.roboto-mono
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    systemPackages =
      with pkgs;
      map lib.lowPrio [
        curl
        gitMinimal
        ssh-to-age
        age
        sops
      ];
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  users.groups.peter = { };
  users.users.peter = {
    isNormalUser = true;
    description = "Peter Varnai";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    group = "peter";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJnGisJWr3z8f9ACsflkXSPZEItkLkI4NJkC+oJ1ZYkl peter@varnai.dev"
    ];
  };

  system.stateVersion = "25.05";
}
