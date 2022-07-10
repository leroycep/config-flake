{ pkgs, ... }:
{
  home.packages = [ pkgs.wlsunset ];
  # TODO: Group wlsunset part of river config with this
  services.wlsunset.latitude = "42";
  services.wlsunset.longitude = "-112";
}
