{ pkgs, ... }:
{
  home.packages = [
    pkgs.anki-bin
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
        "18:00" "18:05" "18:10" "18:15" "18:20" "18:25" "18:30" "18:35" "18:40" "18:45" "18:50" "18:55" "19:00"
        
        # Bedtime
        "21:45"
        "22:00" "22:15" "22:30" "22:45"
        "23:00" "23:15" "23:30" "23:45"
        "00:00" "00:15" "00:30" "00:45"
        "01:00" "01:15" "01:30" "01:45"
        "02:00" "02:15" "02:30" "02:45"
        "03:00" "03:15" "03:30" "03:45"
        "04:00" "04:15" "04:30" "04:45"
        "05:00" "05:15" "05:30" "05:45"
        "06:00" "06:15" "06:30" "06:45"
        "07:00" "07:15" "07:30" "07:45"
        "08:00"
      ];
    };
    
    Install = { WantedBy = ["timers.target"]; };
  };

  # ssh-agent
  # https://stackoverflow.com/questions/18880024/start-ssh-agent-on-login
  systemd.user.services.ssh-agent = {
    Unit = { Description = "SSH key agent"; };
    
    Service = {
      Type = "simple";
      Environment = "SSH_AUTH_SOCK=%t/ssh-agent.socket";
      ExecStart = ''${pkgs.openssh}/bin/ssh-agent -D -a $SSH_AUTH_SOCK'';
    };
    
    Install = {
      WantedBy = ["default.target"];
    };
  };

}
