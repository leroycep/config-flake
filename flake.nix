{
  description = "my machine configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.home-manager.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, nixpkgs, home-manager }: {

    nixosConfigurations."renvi" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./cachix.nix
        home-manager.nixosModules.home-manager

        ({ pkgs, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # login screen
          environment.systemPackages = [
            pkgs.greetd.tuigreet
          ];

          services.greetd.enable = true;
          services.greetd.settings = {
            terminal.vt = 2;
            default_session = {
              command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
              user = "greeter";
            };
          };
        })

        ./local.nix
        ./renvi/renvi.nix
      ];
    };
  };
}
