{
  enable = true;
  systemdTarget = "graphical-session.target";
  profiles = {

    laptop-lid-closed.outputs = [
      {criteria = "Dell Inc. DELL P2717H"; position = "0,0"; transform = "90";}
      {criteria = "ViewSonic Corporation XG2402"; position = "1080,0";}
    ];

    home-desk.outputs = [
      {criteria = "Dell Inc. DELL P2717H"; position = "0,0"; transform = "90";}
      {criteria = "ViewSonic Corporation XG2402"; position = "1080,0";}
      {criteria = "eDP-1"; position = "1080,1080";}
    ];

    strong-independent-laptop.outputs = [
      {criteria = "eDP-1"; scale = 1.5;}
    ];

  };
}
