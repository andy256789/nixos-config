{
    description = "Andy's NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        nixos-hardware.url = "github:NixOS/nixos-hardware/master";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "github:hyprwm/Hyprland";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, hyprland, nixvim, nixos-hardware, ... }@inputs: let
        settings = {
            stateVersion = "25.05";  

            system   = "x86_64-linux";
            hostname = "andy-desktop";
            username = "andy";
        };

    in {
        nixosConfigurations = {
            andy-desktop = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs settings; };
                modules = [
                    ./hosts/${settings.hostname}

                    home-manager.nixosModules.home-manager
                    {
                        home-manager = {
                            useGlobalPkgs    = true;
                            useUserPackages  = true;
                            extraSpecialArgs = { inherit inputs settings; };

                            users.${settings.username} = import ./hosts/${settings.hostname}/home.nix;
                        };
                    }
                ];
            };
        };

        homeConfigurations = {
            "${settings.hostname}" = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs {
                    system = settings.system;
                    config.allowUnfree = true;
                };
                extraSpecialArgs = { inherit inputs settings; };
                modules = [
                    ./hosts/${settings.hostname}/home.nix
                ];
            };
        };
    };
}
