{ ... }:

{

  programs.tmux = {
    enable = true;
    keyMode = "vi";

    prefix = "C-t";

    extraConfig = ''
      # Use v and s to split windows, like vim
      bind-key v split-window -h -c '#{pane_current_path}'
      unbind-key s
      bind-key s split-window -v -c '#{pane_current_path}'

      # Toggle through layouts
      bind-key Space next-layout

      # Use <prefix> C-{hjkl} to move between panes
      bind-key C-h select-pane -L
      bind-key C-j select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l select-pane -R

      bind-key l last-window
      bind-key C-w select-pane -t :.+
      bind-key w   select-pane -t :.-

      # Use <prefix> C-t to renumber windows
      bind-key C-t move-window

      # No delay for <Esc>
      set -sg escape-time 50

      # Start selection with v, copy with y
      bind-key -Tcopy-mode-vi 'v' send-keys -X begin-selection
      bind-key -Tcopy-mode-vi 'y' send-keys -X copy-selection

      # Custom selectors
      bind-key C-f if-shell "tmux list-windows | grep finch" "find-window -N finch" \
         "new-window -n finch finch; swap-window -s finch -t 0"

      # Terminal colors
      if-shell "[ \"$TERM\" = \"alacritty\" ]" {
        set -g default-terminal "alacritty"
      } {
        set -g default-terminal "screen-256color"
      }

      # Reloading
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded..."

      # Load theme
      source $HOME/.config/tmux/tmuxline.conf
    '';
  };

  home.file = {
    ".config/tmux/tmuxline.conf".source = ./tmuxline.conf;
  };

}
