{
  description = "Home Manager configuration for serena@serena-desktop";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixGL.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    git-branchless.url = "github:arxanas/git-branchless";
    helix-nightly.url = "github:helix-editor/helix/master";
  };

  outputs = { nixGL, nixpkgs, home-manager, helix-nightly, git-branchless, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."serena" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          helix-nightly = helix-nightly;
          system = system;
          nixGL = nixGL;
	  git-branchless = git-branchless;
        };

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
