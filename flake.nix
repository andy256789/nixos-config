{
  description = "Andy's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
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
