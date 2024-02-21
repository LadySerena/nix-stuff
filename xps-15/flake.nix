{
  description = "Home Manager configuration of kitty@strawberry-switchblade";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixGL.url = "github:nix-community/nixGL";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-nightly.url = "github:helix-editor/helix/master";
  };

  outputs = { nixGL, nixpkgs, home-manager, helix-nightly, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."kitty" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];
        extraSpecialArgs = {  helix-nightly=helix-nightly; system=system; nixGL=nixGL;};

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
