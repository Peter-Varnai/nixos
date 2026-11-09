{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Headless box reached over SSH: only the terminal tooling, no GUI modules
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/neovim/default.nix
    ../../modules/home/tmux/tmux.nix
  ];

  wayland.enable = false;

  programs.tmux.shortcut = "a";

  # No local display: send copies back to the SSH client's clipboard via OSC 52
  programs.tmux.extraConfig = ''
    set -g set-clipboard on
    bind -T copy-mode-vi y send -X copy-selection-and-cancel

    # Reached from the Mac, where Option/Ctrl+Tab rarely make it through:
    # also offer the foreus prefix-based pane keys alongside the Alt ones
    bind Up    select-pane -U
    bind Down  select-pane -D
    bind Left  select-pane -L
    bind Right select-pane -R

    bind -r S-Up    resize-pane -U 5
    bind -r S-Down  resize-pane -D 5
    bind -r S-Left  resize-pane -L 5
    bind -r S-Right resize-pane -R 5
  '';

  programs.neovim.initLua = lib.mkAfter ''
    vim.g.clipboard = 'osc52'
  '';

  home = {
    username = "peter";
    homeDirectory = "/home/peter";
    stateVersion = "26.05";
  };
}
