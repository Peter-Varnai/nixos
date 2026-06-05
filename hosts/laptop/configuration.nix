{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./services/postgresql.nix
    inputs.sops-nix.nixosModules.sops
    # ./services/petervarnai_net.nix
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 5;
  };

  networking.hostName = "peter"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # environment.variables = rec {
  #   EDITOR = "nvim";
  #   VISUAL = "nvim";
  # };

  services = {
    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    blueman.enable = true;

    # Configure keymap in X11
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Enable sound with pipewire.
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  hardware = {
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  # sops-nix secrets
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/peter/.config/sops/age/keys.txt";

    secrets = {
      "openai_api_key" = { };
    };
  };

  users.users.peter = {
    isNormalUser = true;
    description = "Peter Varnai";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
      "recursive-nix"
    ];
    settings.system-features = [ "recursive-nix" ];

    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Nerd Fonts (specific fonts for development)
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

  environment.systemPackages = with pkgs; [
    fzf
    ripgrep
    git
    wget
    curl
    lsof

    htop
    btop

    kdePackages.kate
    ssh-to-age
    age
    sops
    home-manager
  ];

  system.stateVersion = "25.05"; # Did you read the comment?
}
