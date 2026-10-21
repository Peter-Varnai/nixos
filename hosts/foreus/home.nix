{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home
    ./psql.nix
  ];

  wireshark.enable = false;
  alacritty.enable = false;

  programs.git.settings.user.email = "pv@foreusgroup.com";

  # macOS login shell is zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
    '';
    envExtra = ''
      # Nix daemon PATH recovery (in case macOS update overwrites /etc/zshrc)
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };

  # /usr/bin/vi shadows the nix-provided vi on macOS PATH
  home.shellAliases.vi = "nvim";

  # Prefix is Ctrl+a, same as NixOS; the terminals map Cmd+a to Ctrl+a
  programs.tmux.shortcut = "a";

  programs.tmux.extraConfig = ''
    # macOS: use prefix-based pane keys instead of Option/Ctrl+Tab
    unbind -n M-Up
    unbind -n M-Down
    unbind -n M-Left
    unbind -n M-Right
    unbind -n M-S-Up
    unbind -n M-S-Down
    unbind -n M-S-Left
    unbind -n M-S-Right
    unbind -n C-Tab
    unbind -n C-S-Tab

    bind Up    select-pane -U
    bind Down  select-pane -D
    bind Left  select-pane -L
    bind Right select-pane -R

    # Shift, not Ctrl: macOS takes Ctrl+arrows for Mission Control/Spaces
    bind -r S-Up    resize-pane -U 5
    bind -r S-Down  resize-pane -D 5
    bind -r S-Left  resize-pane -L 5
    bind -r S-Right resize-pane -R 5
  '';

  programs.neovim.initLua = lib.mkAfter ''
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
  '';

  home = {
    username = "petervarnai";
    homeDirectory = "/Users/petervarnai";

    packages = with pkgs; [
      lf
      fastfetch
      zip
      gitui
      diffnav # git diff | diffnav: file tree + delta rendering

    ];

    stateVersion = "26.05";
  };
}
