{
  description = "Andy's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        andy-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/andy-desktop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.andy = import ./hosts/andy-desktop/home.nix;
            }
          ];
          specialArgs = {
            inherit self inputs hyprland;
            username = "andy";
            host = "andy-desktop";
          };
        };
      };
    };
}