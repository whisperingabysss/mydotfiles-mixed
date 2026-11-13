#if status is-interactive
# Commands to run in interactive sessions can go here
set -U fish_greeting
pfetch
function fish_prompt
    string join '' -- (set_color purple) (prompt_pwd) (set_color white) ' ➜ '
end

fish_add_path /home/life/.spicetify

# Created by `pipx` on 2026-10-06 20:06:27
set PATH $PATH /home/life/.local/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH


# Added by Antigravity CLI installer
set -gx PATH "/home/life/.local/bin" $PATH
