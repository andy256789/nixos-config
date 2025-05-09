{
	description = "Andy's NixOS configuration";
  # https://discourse.nixos.org/t/how-to-set-up-cachix-in-flake-based-nixos-config/31781
  # use --accept-flake-config when rebuilding

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
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
