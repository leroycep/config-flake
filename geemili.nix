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
    pkgs.mako
  ];

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "qutebrowser";
  };
  
  xdg.configFile."river/settings" = {
    executable = true;
    source =./config/river-settings.sh;
  };
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      $XDG_CONFIG_HOME/river/settings
      rivertile -view-padding 0 -outer-padding 0
    '';
    onChange= ''
      $XDG_CONFIG_HOME/river/settings
    '';
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
        ",c" = "spawn chromium {url}";
        ",d" = "config-cycle content.user_stylesheets '${./config/qutebrowser/global-dark-mode.css}' ''";
        "<Ctrl+e>" = "edit-text";
      };
    };
    settings = {
      editor.command = ["foot" "--override=title=qutebrowser edit-text" "hx" "{file}"];
      colors.webpage.preferred_color_scheme = "dark";
    };
  };

}
