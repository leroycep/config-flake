{
  mainBar = {
    layer = "top";
    position = "bottom";
    modules-left = ["river/tags"];
    modules-center = ["river/window"];
    modules-right = ["pulseaudio" "network" "battery" "clock" "tray"];
    battery = {
      format = "{capacity}% {icon}";
      format-icons = ["" "" "" "" ""];
    };
    clock = {
      format = "{:%m/%d  %H:%M}";
      format-alt = "{:%Y-%m-%d  %H:%M}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
    "river/window" = {
      format = "{}";
    };
    network = {
      format-wifi = "";
      format-ethernet = "{ipaddr}/{cidr} ";
      tooltip-format = "{ifname} via {gwaddr} ";
      format-linked = "{ifname} (No IP) ";
      format-disconnected = "⚠";
      format-alt = "{ifname} = {ipaddr}/{cidr}";
    };
    pulseaudio = {
      format = "{volume}% {icon} {format_source}";
      format-bluetooth = "{volume}% {icon} {format_source}";
      format-bluetooth-muted = " {icon} {format_source}";
      format-muted = " {format_source}";
      format-source = "{volume}% ";
      format-source-muted = "";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = ["" "" ""];
      };
      on-click = "pavucontrol";
    };
    tray = {
      spacing = 10;
    };
  };
}

