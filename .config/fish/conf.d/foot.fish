# Foot doesnt recognize certain keys combinations by default
# https://codeberg.org/dnkl/foot/issues/628#issuecomment-283026

# Shift-Return
bind \e\[27\;2\;13\~ accept-autosuggestion

# Control-Return
bind \e\[27\;5\;13\~ accept-autosuggestion execute

# Control-Shift-Return
bind \e\[27\;6\;13\~ execute

# Super-Return
bind \e\[27\;9\;13\~ execute

# Super-Shift-Return
bind \e\[27\;10\;13\~ execute
