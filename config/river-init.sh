#!/usr/bin/env sh

# See the river(1), riverctl(1), and rivertile(1) man pages for
# documentation.

# Settings
riverctl set-cursor-warp on-output-change

# Starting things
riverctl map normal Super Return spawn foot
riverctl map normal Super Space spawn "fuzzel --terminal=foot"

riverctl spawn "kanshi > /tmp/kanshi.${XDG_VTNR}.${USER}.log 2>&1"
riverctl spawn "waybar > /tmp/waybar.${XDG_VTNR}.${USER}.log 2>&1"
riverctl spawn "mako > /tmp/mako.${XDG_VTNR}.${USER}.log 2>&1"
# TODO: Group with 2_areas/sleep
riverctl spawn "wlsunset -l 42 -L -112"

# Ending things
riverctl map normal Super+Shift Q close # close window
riverctl map normal Super+Shift E exit # exit river

# Notification hotkeys
riverctl map normal Super i spawn "makoctl dismiss"
riverctl map normal Super+Shift i spawn "makoctl restore"

# Cycle through views
riverctl map normal Super+Shift Return zoom
riverctl map normal Super Tab focus-view next
riverctl map normal Super+Shift Tab focus-view previous

# Switch monitors
riverctl map normal Super H focus-output left
riverctl map normal Super K focus-output up
riverctl map normal Super J focus-output down
riverctl map normal Super L focus-output right

riverctl map normal Super+Shift H spawn "riverctl send-to-output left; riverctl focus-output left"
riverctl map normal Super+Shift K spawn "riverctl send-to-output up; riverctl focus-output up"
riverctl map normal Super+Shift J spawn "riverctl send-to-output down; riverctl focus-output down"
riverctl map normal Super+Shift L spawn "riverctl send-to-output right; riverctl focus-output right"

riverctl map normal Super+Shift F toggle-float
riverctl map normal Super F toggle-fullscreen

# Super+{Up,Right,Down,Left} to change layout orientation
riverctl map normal Super Up    send-layout-cmd rivertile "main-location top"
riverctl map normal Super Right send-layout-cmd rivertile "main-location right"
riverctl map normal Super Down  send-layout-cmd rivertile "main-location bottom"
riverctl map normal Super Left  send-layout-cmd rivertile "main-location left"

# Super + Left Mouse Button to move views
riverctl map-pointer normal Super BTN_LEFT move-view

# Super + Right Mouse Button to resize views
riverctl map-pointer normal Super BTN_RIGHT resize-view

for i in $(seq 1 9)
do
    tags=$((1 << ($i - 1)))

    # Super+[1-9] to focus tag [0-8]
    riverctl map normal Super $i set-focused-tags $tags

    # Super+Shift+[1-9] to tag focused view with tag [0-8]
    riverctl map normal Super+Shift $i set-view-tags $tags

    # Super+Ctrl+[1-9] to toggle focus of tag [0-8]
    riverctl map normal Super+Control $i toggle-focused-tags $tags

    # Super+Shift+Ctrl+[1-9] to toggle tag [0-8] of focused view
    riverctl map normal Super+Shift+Control $i toggle-view-tags $tags
done

# Super+0 to focus all tags
# Super+Shift+0 to tag focused view with all tags
all_tags=$(((1 << 32) - 1))
riverctl map normal Super 0 set-focused-tags $all_tags
riverctl map normal Super+Shift 0 set-view-tags $all_tags

# Various media key mapping examples for both normal and locked mode which do
# not have a modifier
for mode in normal locked
do
    # Eject the optical drive (well if you still have one that is)
    riverctl map $mode None XF86Eject spawn 'eject -T'

    # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
    riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
    riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
    riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

    # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
    riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
    riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
    riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

    # Control screen backlight brightness with light (https://github.com/haikarainen/light)
    riverctl map $mode None XF86MonBrightnessUp   spawn 'light -A 5'
    riverctl map $mode None XF86MonBrightnessDown spawn 'light -U 5'

    # Turn off the laptop screen when close
    #riverctl map-switch $mode lid close
done

# Set background and border color
riverctl background-color 0x002b36
riverctl border-color-focused 0x93a1a1
riverctl border-color-unfocused 0x586e75

# Set keyboard repeat rate
riverctl set-repeat 50 300

# Make certain views start floating
riverctl float-filter-add app-id float
riverctl float-filter-add title "Volume Control"

# Set app-ids and titles of views which should use client side decorations
riverctl csd-filter-add app-id "gedit"

# Set the default layout generator to be rivertile and start it.
# River will send the process group of the init executable SIGTERM on exit.
riverctl default-layout rivertile
rivertile -view-padding 0 -outer-padding 0
