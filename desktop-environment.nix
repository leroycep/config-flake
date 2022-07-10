{ pkgs, ... }:
{
  # login screen
  environment.systemPackages = [
    pkgs.greetd.tuigreet
    pkgs.river
  ];

  services.greetd.enable = true;
  services.greetd.settings = {
    terminal.vt = 2;
    default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd river";
      user = "greeter";
    };
  };
    
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    font-awesome_5
    font-awesome_4
    corefonts
    roboto
    (nerdfonts.override {
      fonts = [ "FiraCode" ];
    })
  ];
}

