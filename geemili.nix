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
  ];

  home.sessionVariables = {
    EDITOR = "hx";
  };

  programs.git = {
    enable = true;
    userName = "LeRoyce Pearson";
    userEmail = "contact@leroycepearson.dev";
  };
  
  programs.qutebrowser = {
    enable = true;
  };

}
