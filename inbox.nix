{ pkgs, ... }:
{
  home.packages = [
    pkgs.anki
    pkgs.bun
    pkgs.dconf
    pkgs.gnome.gnome-system-monitor

    # doesn't support wayland,
    ##pkgs.clockify

    # is a manual log of time hamster 
    ##pkgs.hamster
    ##pkgs.gnome.adwaita-icon-theme
    
    pkgs.super-productivity
    
    # image viewer
    pkgs.imv
    pkgs.gnome.nautilus
    
    pkgs.pavucontrol
    
    pkgs.fd
    
    pkgs.ffmpeg-full
  ];
  
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  

  systemd.user.services.focus-break = {
    Unit = { Description = "Power off computer; attempting to break hyperfocus"; };
    
    Service = {
      ExecStart = ''${pkgs.systemd}/bin/systemctl poweroff'';
    };
  };

  systemd.user.timers.focus-break = {
    Unit = { Description = "Poweroff computer at bedtime"; };
    
    Timer = {
      OnCalendar=[
        # Lunch Break
        "12:00" "12:05" "12:10" "12:15" "12:20" "12:25" "12:30" "12:35" "12:40" "12:45" "12:50" "12:55" "13:00"

        # Chore time
        "17:00" "17:05" "17:10" "17:15" "17:20" "17:25" "17:30" "17:35" "17:40" "17:45" "17:50" "17:55" "18:00"
        
        # Bedtime
        "19:00"
        "20:00" "20:15" "20:30" "20:45"
        "21:00" "21:15" "21:30" "21:45"
        "22:00" "22:15" "22:30" "22:45"
        "23:00" "23:15" "23:30" "23:45"
      ];
    };
    
    Install = { WantedBy = ["timers.target"]; };
  };
}
