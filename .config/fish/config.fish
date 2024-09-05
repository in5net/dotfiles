set -g fish_key_bindings fish_vi_key_bindings
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

zoxide init fish | source
starship init fish | source
fzf --fish | source

abbr --add ta tmux a
abbr --add cls clear
abbr --add gs git status
abbr --add ga git add
abbr --add gc git commit
abbr --add gca git commit -a
abbr --add gco git checkout
abbr --add gcm git commit -m
abbr --add gcb git checkout -b
abbr --add gbd git branch -d
abbr --add gd git diff
abbr --add gb git branch
abbr --add gaa git add -A
abbr --add gps git push
abbr --add gpl git pull --rebase
abbr --add gap git add -p

alias so "source ~/.config/fish/config.fish"
alias ls "eza --icons"
alias ll "eza --long --icons --group-directories-first --header --no-user"
