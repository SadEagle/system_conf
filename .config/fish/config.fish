set fish_greeting
set -gx EDITOR nvim
# TODO: vim deletion inside scope `di(` dont work, need to make ticket. Add ticket?
set -g fish_key_bindings fish_vi_key_bindings

function fish_prompt
    echo -n (set_color green)$USER (set_color blue)(prompt_pwd) (set_color cyan)(fish_git_prompt '(%s)') (set_color blue)'❭ '
end

zoxide init fish | source
#fzf --fish | source
