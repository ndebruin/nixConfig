{
  description = "NixOS system config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

#    waybar.url = "github:Alexays/Waybar/master";
  };

  outputs = { home-manager, self, nixpkgs, ... }@inputs:

	let
		system = "x86_64-linux";

		pkgs = import nixpkgs {
			inherit system;
			config = {
				allowUnfree = true; # possibly change this later
				allowUnfreePredicate = _: true;
			};
		};
		allowed-unfree-packages = [ "slack" ];

	lib = nixpkgs.lib;

	in {
		nixosConfigurations."nixos-dev" = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
				inherit pkgs;
				inherit allowed-unfree-packages;
				inherit system;
			};
			
			modules = [
				./system/configuration.nix
				home-manager.nixosModule
			];
		};
		homeManagerConfigurations.ndebruin = home-manager.lib.homeManagerConfiguration {
			pkgs = import nixpkgs { inherit system; };


			# pass inputs as specialArgs
		        extraSpecialArgs = {
			          inherit inputs;
			          inherit pkgs;
			          inherit allowed-unfree-packages;
			};

			# import home.nix
			modules = [
				./home/home.nix
			];
		};
	};
}
