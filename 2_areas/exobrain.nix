{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacsPgtk;
  };

  services.syncthing.enable = true;
  services.syncthing.tray.enable = true;
}
