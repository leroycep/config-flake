systemctl --user reset-failed kanshi waybar wlsunset

riverctl spawn "mako > /tmp/mako.${XDG_VTNR}.${USER}.log 2>&1"
riverctl spawn "systemctl --user start kanshi"
riverctl spawn "systemctl --user start waybar"

# TODO: Group with 2_areas/sleep
riverctl spawn "systemctl --user start wlsunset"

