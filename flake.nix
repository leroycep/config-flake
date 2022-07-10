{
  description = "my machine configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nc-emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, home-manager, nc-emacs-overlay }: 
    let
      system = "x86_64-linux";
      the-pkgs-overlay = import nixpkgs {
        inherit system;
        overlays = [ nc-emacs-overlay.overlay ];
        config.allowUnfree = true;
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
        ./geemili.nix
        ./2_areas/exobrain.nix
        ./2_areas/sleep.nix
      ];
    };
  };
}
