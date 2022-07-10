{ pkgs, ... }:
{
  home.username = "geemili";
  home.homeDirectory = "/home/geemili/";
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.helix
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
    pkgs.zoxide
    pkgs.ranger
    pkgs.fuzzel
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.pamixer
    pkgs.ripcord
  ];

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "qutebrowser";
  };
  
  xdg.configFile."river/settings" = {
    executable = true;
    source = ./config/river-settings.sh;
  };
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      $HOME/.config/river/settings
      rivertile -view-padding 0 -outer-padding 0
    '';
    onChange= ''
      #!/usr/bin/env sh
      $HOME/.config/river/settings
    '';
  };
  
  services.kanshi = import ./config/kanshi.nix;

  programs.foot.enable = true;
  programs.foot.settings = {
    main = {
      shell = "${pkgs.nushell}/bin/nu";
      dpi-aware = "yes";
      font = "Fira Code:size=11";
    };
  };
  programs.nushell.enable = true;
  xdg.configFile."nushell/zoxide.nu".source = ./config/nushell/zoxide.nu;
  programs.nushell.envFile.source = ./config/nushell/env.nu;
  programs.nushell.configFile.source = ./config/nushell/config.nu;

  xdg.configFile."ranger/plugins/osc7.py".source = ./config/ranger/plugin-ranger-osc7.py;
  xdg.configFile."ranger/rc.conf".text = ''
    set vcs_aware true
  '';

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
