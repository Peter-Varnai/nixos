{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    clock24 = true;
    historyLimit = 50000;

    plugins = with pkgs.tmuxPlugins; [ better-mouse-mode cpu battery ];

    extraConfig = ''
          set -g default-terminal "xterm-256color"
          set -ga terminal-overrides ",*256col*:Tc"
          set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
          set-environment -g COLORTERM "truecolor"

          # Set up copying within a tmux terminal
          setw -g mode-keys vi
          bind -T copy-mode-vi y send -X copy-pipe-and-cancel "wl-copy"


      # easy-to-remember split pane commands
          bind -n M-S-Up    resize-pane -U 5
          bind -n M-S-Down  resize-pane -D 5
          bind -n M-S-Left  resize-pane -L 5
          bind -n M-S-Right resize-pane -R 5

          bind -n M-Up    select-pane -U
          bind -n M-Down  select-pane -D
          bind -n M-Left  select-pane -L
          bind -n M-Right select-pane -R

          # Cycle through windows (tabs) with Ctrl + Tab and Ctrl + Shift + Tab
          bind -n C-Tab next-window
          bind -n C-S-Tab previous-window

          bind h split-window -h -c "#{pane_current_path}"
          bind v split-window -v -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"

          set -g status-right '#[fg=black,bg=color15] #{cpu_percentage} |#[fg=black] #{battery_percentage}  %H:%M '
          run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
          run-shell ${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/battery.tmux

          # Allow mouse scroll to enter copy mode automatically
          set -g mouse on

          # Make scroll wheel and Shift-PageUp/Down work as expected
          bind -T root WheelUpPane if-shell -F "#{mouse_any_flag}" "send-keys -M" "if -F '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e'"
          bind -T root WheelDownPane if-shell -F "#{pane_in_mode}" "send-keys -M" "send-keys -M"

          # Optional: use arrow keys to scroll line-by-line in copy mode
          bind -T copy-mode-vi Up send -X scroll-up
          bind -T copy-mode-vi Down send -X scroll-down
          bind -T copy-mode-vi PageUp send -X page-up
          bind -T copy-mode-vi PageDown send -X page-down
    '';
  };

  # programs.tmate = {
  #   enable = true;
  #   # FIXME: This causes tmate to hang.
  #   # extraConfig = config.xdg.configFile."tmux/tmux.conf".text;
  # };
}
