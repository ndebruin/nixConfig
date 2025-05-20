{
  description = "NixOS system config flake";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

	nur = {
		url = "github:nix-community/NUR";
		inputs.nixpkgs.follows = "nixpkgs";
	};

#    waybar.url = "github:Alexays/Waybar/master";
  };

  outputs = { home-manager, self, nixpkgs, nixpkgs-unstable, nur, ... }@inputs:

	let
		system = "x86_64-linux";

		pkgs = import nixpkgs {
			inherit system;
			overlays = [ nur.overlays.default ];
			config = {
				allowUnfree = true; # possibly change this later
				allowUnfreePredicate = _: true;
			};
		};
		allowed-unfree-packages = [ "slack" ];
		pkgs-unstable = import nixpkgs-unstable {
			inherit system;
			config = {
				allowUnfree = false;
			};
		};

	lib = nixpkgs.lib;

	in {
		nixosConfigurations."nixos-dev2" = nixpkgs.lib.nixosSystem {
			specialArgs = {
				inherit inputs;
				inherit pkgs;
				inherit pkgs-unstable;
				inherit allowed-unfree-packages;
				inherit system;
				inherit nur;
			};

			
			
			modules = [
				./system/configuration.nix
				home-manager.nixosModule
				nur.modules.nixos.default
			];
		};
		homeManagerConfigurations.ndebruin = home-manager.lib.homeManagerConfiguration {
			pkgs = import nixpkgs { inherit system; };


			# pass inputs as specialArgs
		        extraSpecialArgs = {
			          inherit inputs;
			          inherit pkgs;
					  inherit pkgs-unstable;
					  inherit nur;
			          inherit allowed-unfree-packages;
			};

			# import home.nix
			modules = [
				./home/home.nix
			];
		};
	};
}
