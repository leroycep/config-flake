{ pkgs, ... }:
{
  home.username = "geemili";
  home.homeDirectory = "/home/geemili/";
  home.stateVersion = "22.11";

  home.packages = [
    pkgs.helix
    pkgs.python3Packages.python-lsp-server

    pkgs.xclip
    pkgs.httpie
    pkgs.bitwarden-cli
    pkgs.element-desktop
    pkgs.dolphin
    pkgs.sway
    pkgs.vorta
    pkgs.nushell
    pkgs.kanshi
    pkgs.zoxide
    pkgs.ranger
    pkgs.fuzzel
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.wl-clipboard
    pkgs.pamixer
    pkgs.ripcord

    # "qutebrowser/userscripts/qute-bitwarden-fuzzel"
    pkgs.ripgrep
  ];

  programs.bash.enable = true;
  home.sessionVariables = {
    EDITOR = "hx";
    BROWSER = "qutebrowser";
    SHELL = "${pkgs.nushell}/bin/nu";
  };
  
  xdg.configFile."river/settings" = {
    executable = true;
    source = ./config/river-settings.sh;
  };
  xdg.configFile."river/services" = {
    executable = true;
    source = ./config/river-services.sh;
  };
  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      echo "Start of river init file!"
      $HOME/.config/river/settings

      riverctl spawn "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY"
      riverctl spawn "${pkgs.systemd}/bin/systemctl --user start river-session.target"
      $HOME/.config/river/services

      rivertile -view-padding 0 -outer-padding 0
    '';
    onChange= ''
      #!/usr/bin/env sh
      $HOME/.config/river/settings
      $HOME/.config/river/services
    '';
  };
  systemd.user.targets.river-session = {
    Unit = {
      Description = "river compositor session";
      BindsTo = [ "graphical-session.target" ];
    };
  };
  
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = import ./config/waybar/config.nix;
    style = ./config/waybar/style.css;
  };

  programs.mako.enable = true;
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
    map S shell ${pkgs.nushell}/bin/nu
  '';

  programs.git = {
    enable = true;
    userName = "LeRoyce Pearson";
    userEmail = "contact@leroycepearson.dev";
    lfs.enable = true;
    extraConfig.init.defaultBranch = "dev";
  };
  programs.gitui.enable = true;
  
  programs.gh = {
    enable = true;
    enableGitCredentialHelper = true;
  };
  
  programs.qutebrowser = {
    enable = true;
    keyBindings = {
      normal = {
        ",b" = "spawn ${pkgs.qute-bitwarden}/bin/qute-bitwarden {url}";
        ",c" = "spawn chromium {url}";
        ",d" = "config-cycle content.user_stylesheets '${./config/qutebrowser/global-dark-mode.css}' ''";
        "<Ctrl+e>" = "edit-text";
      };
    };
    settings = {
      editor.command = ["foot" "--override=title=qutebrowser edit-text" "hx" "{file}"];
      colors.webpage.preferred_color_scheme = "dark";
      qt.highdpi = true;
    };
  };

  services.udiskie.enable = true;
  services.udiskie.settings.program_options.file_manager = "dolphin";
  services.udiskie.settings.program_options.terminal = "foot ranger";
  
  gtk.enable = true;
  #services.dbus.packages = [pkgs.dconf];
  gtk.theme.name = "Dracula";
  gtk.theme.package = pkgs.dracula-theme;
}
