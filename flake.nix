{
  description = "my machine configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nc-emacs-overlay.url = "github:nix-community/emacs-overlay";
    nc-emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
    
    qute-bitwarden-flake.url = "github:leroycep/qute-bitwarden-flake";
  };

  outputs = { self, nixpkgs, home-manager, nc-emacs-overlay, qute-bitwarden-flake }: 
    let
      system = "x86_64-linux";
      the-pkgs-overlay = import nixpkgs {
        inherit system;
        overlays = [
          nc-emacs-overlay.overlay
          (self: super: {
            qute-bitwarden = qute-bitwarden-flake.packages.x86_64-linux.default;
          })
        ];
        config.allowUnfree = true;

        ## For try out clockify
        #config.permittedInsecurePackages = [
        #  "electron-11.5.0"
        #];
      };
    in {

    nixosConfigurations.renvi = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ./cachix.nix
        home-manager.nixosModules.home-manager

        ({ pkgs, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          environment.systemPackages = [
            pkgs.home-manager
          ];
        })
            
        ./desktop-environment.nix

        ./local.nix
        ./renvi/renvi.nix
      ];
    };

    homeConfigurations.geemili = home-manager.lib.homeManagerConfiguration {
      pkgs = the-pkgs-overlay;
      modules = [
        ./inbox.nix
        ./geemili.nix
        ./2_areas/exobrain.nix
        ./2_areas/sleep.nix
        ./2_areas/leif.nix
        ./2_areas/datafy-interview.nix
      ];
    };
  };
}
