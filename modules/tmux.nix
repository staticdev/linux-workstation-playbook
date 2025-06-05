{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    keyMode = "vi";
    terminal = "screen-256color";
    baseIndex = 1;
    escapeTime = 0;
    clock24 = true;
    historyLimit = 100000;
    extraConfig = ''
      bind r source-file /etc/tmux.conf
      bind -  split-window -v  -c '#{pane_current_path}'
      bind \\ split-window -h  -c '#{pane_current_path}'
      bind _  split-window -vf  -c '#{pane_current_path}'
      bind | split-window -hf  -c '#{pane_current_path}'
      bind -r C-k resize-pane -U
      bind -r C-j resize-pane -D
      bind -r C-h resize-pane -L
      bind -r C-l resize-pane -R
      bind -r k select-pane -U
      bind -r j select-pane -D
      bind -r h select-pane -L
      bind -r l select-pane -R


      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe
      bind -T copy-mode-vi Enter send-keys -X copy-pipe

      set -g set-titles on
      set -g mouse on
      set -g monitor-activity on
      set -g default-command "''${SHELL}"
      set -s set-clipboard external
      set -g copy-command "${pkgs.wl-clipboard}/bin/wl-copy"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set -g status-interval 60
      set -g status-bg black
      set -g status-fg green
      set -g window-status-activity-style fg=red
      set -g status-left-length 100
      set -g status-left  '#{?client_prefix,#[fg=red]PFX,   } #[fg=green](#S) '
      set -g status-right-length 100
      set -g status-right '#[fg=yellow]%Y/%m(%b)/%d %a %H:%M#[default]'
      set -g pane-border-lines double

      set-environment -g COLORTERM "truecolor"
    '';
  };
}
