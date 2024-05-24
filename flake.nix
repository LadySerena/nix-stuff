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

  outputs =
    { nixGL, nixpkgs, home-manager, helix-nightly, git-branchless, ... }:
    let
      x86_linux = "x86_64-linux";
      args = (s: { inherit helix-nightly nixGL git-branchless; } // s);
    in {
      homeConfigurations."serena" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = args {
          system = x86_linux;
          homeDir = "/home/serena";
          username = "serena";
        };

        pkgs = import nixpkgs { system = x86_linux; };

        modules = [ ./home.nix ];
      };

      homeConfigurations."kitty" = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = args {
          system = x86_linux;
          homeDir = "/home/kitty";
          username = "kitty";
        };
        pkgs = import nixpkgs { system = x86_linux; };

        modules = [ ./home.nix ];
      };
    };
}
