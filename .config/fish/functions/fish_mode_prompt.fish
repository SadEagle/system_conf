# Delete bold from default
function fish_mode_prompt --description "Display vi prompt mode"
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set_color red
                echo '[N]'
            case insert
                set_color green
                echo '[I]'
            case replace_one
                set_color green
                echo '[R]'
            case replace
                set_color cyan
                echo '[R]'
            case visual
                set_color magenta
                echo '[V]'
        end
        set_color normal
        echo -n ' '
    end
end
