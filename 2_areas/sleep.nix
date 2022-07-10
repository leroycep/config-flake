{ pkgs, ... }:
{
  # TODO: Group wlsunset part of river config with this
  services.wlsunset.enable = true;
  services.wlsunset.latitude = "42";
  services.wlsunset.longitude = "-112";
}
