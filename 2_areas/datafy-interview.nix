{ pkgs, ... }:
{
  home.packages = [
    pkgs.zoom
    pkgs.slack
  ];
}
