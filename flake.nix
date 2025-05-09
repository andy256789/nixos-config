{
	description = "Andy's NixOS configuration";
	nixConfig = {
		extra-substituters = [
			"https://hyprland.cachix.org/"
			"https://cache.nixos.org/"
		];
		extra-trusted-public-keys = [
			"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
			"cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
		];
	};

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
							home-manager.extraSpecialArgs = {
								inherit inputs;
								username = "andy";
							};
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
