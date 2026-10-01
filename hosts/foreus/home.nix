{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home
  ];

  wireshark.enable = false;

  programs.tmux.extraConfig = ''
    # macOS: Option doesn't send Meta; use prefix-based pane keys
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

    bind C-Up    resize-pane -U 5
    bind C-Down  resize-pane -D 5
    bind C-Left  resize-pane -L 5
    bind C-Right resize-pane -R 5
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
    ];

    stateVersion = "26.05";
  };
}
