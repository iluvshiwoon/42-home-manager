{
	description = "Home Manager configuration of kgriset";

	inputs = {
# Specify the source of Home Manager and Nixpkgs.
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser.url = "github:youwen5/zen-browser-flake";
		neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

# optional, but recommended if you closely follow NixOS unstable so it shares
# system libraries, and improves startup time
# NOTE: if you experience a build failure with Zen, the first thing to check is to remove this line!
		zen-browser.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs =
	{self, nixpkgs, home-manager, ... }@inputs:
	let
		system = "x86_64-linux";
	pkgs = nixpkgs.legacyPackages.${system};
	inherit (self) outputs;
	in
	{
		homeConfigurations."kgriset" = home-manager.lib.homeManagerConfiguration {
			inherit pkgs;

# Specify your home configuration modules here, for example,
# the path to your home.nix.
			modules = [ ./home.nix ];

# Optionally use extraSpecialArgs
# to pass through arguments to home.nix
			extraSpecialArgs = {inherit inputs outputs;};
		};
	};
}
