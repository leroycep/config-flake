{ pkgs, ... }:
{
  home.username = "geemili";
  home.homeDirectory = "/home/geemili/";
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.helix
    pkgs.foot
    pkgs.xclip
    pkgs.httpie
    pkgs.bitwarden-cli
    pkgs.element-desktop
    pkgs.dolphin
    pkgs.sway
    pkgs.vorta
    pkgs.nushell
    pkgs.kanshi
  ];

  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "qutebrowser";
  };
  
  xdg.configFile."river/init" = {
    executable = true;
    source = ./config/river-init.sh;
  };
  
  services.kanshi = import ./config/kanshi.nix;

  programs.waybar = {
    enable = true;
    settings = import ./config/waybar/config.nix;
    style = ./config/waybar/style.css;
  };

  programs.git = {
    enable = true;
    userName = "LeRoyce Pearson";
    userEmail = "contact@leroycepearson.dev";
  };
  
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };
  
  programs.qutebrowser = {
    enable = true;
    keyBindings = {
      normal = {
        ",b" = "spawn --userscript qute-bitwarden";
      };
    };
  };

}
