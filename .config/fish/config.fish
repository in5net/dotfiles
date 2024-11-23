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

if command -q zoxide
    zoxide init fish | source
end
if command -q starship
    starship init fish | source
end
if command -q fzf
    fzf --fish | source
end
if command -q uv
    uv generate-shell-completion fish | source
    uvx --generate-shell-completion fish | source
end

set -gx EDITOR nvim
set -gx NPM_CHECK_INSTALLER ni

set -gx FZF_DEFAULT_OPTS "--layout=reverse --cycle --ansi"
set -gx FZF_DEFAULT_COMMAND "fd -tf --color=always"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

abbr --add cls clear

# Tmux
abbr --add ta tmux a
abbr --add tns tmux new-session -s
abbr --add tls tmux ls
abbr --add tks tmux kill-server

alias so "source ~/.config/fish/config.fish"
alias refenv "source ~/.local/bin/env.fish"
alias ls "eza --icons"
alias ll "eza --long --icons --group-directories-first --header --no-user"
alias lt "eza --tree --icons --group-directories-first --header --no-user"

# Git
abbr --add gs git status
abbr --add ga git add
abbr --add gc git commit
abbr --add gca git commit -a
abbr --add gcm git commit -m
abbr --add gcb git checkout -b
abbr --add gbd git branch -d
abbr --add gd git diff
abbr --add gb git branch
abbr --add gaa git add .
abbr --add gps git push
abbr --add gpl git pull --rebase
abbr --add gap git add -p

function gco
    git branch | fzf --preview 'git show --color=always {-1}' \
        --bind 'enter:become(git checkout {-1})' \
        --height 40%
end

function gm
    git branch | fzf --preview 'git show --color=always {-1}' \
        --bind 'enter:become(git merge {-1})' \
        --height 40%
end
