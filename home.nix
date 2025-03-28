{ pkgs, system, helix-nightly, nixGL, username, homeDir, lib, ... }:
let
  wrap = input_package:
    (import ./common/wrap.nix ({
      inherit pkgs system nixGL lib input_package;
    }));

in {

  # waiting on https://github.com/nametake/golangci-lint-langserver/pull/52 to be merged
  nixpkgs.overlays = [
    (final: previous: {
      golangci-lint-langserver = previous.golangci-lint-langserver.overrideAttrs
        (oldAttrs: { doCheck = false; });
    })
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    (import ./common/packages.nix ({
      inherit pkgs;
      extra = [ (wrap pkgs.rpi-imager) ];
    }))
  ] ++ import ./common;

  programs.helix = {
    enable = true;
    package = helix-nightly.packages.${system}.default;
  };

  programs.wezterm = {
    package = (wrap pkgs.wezterm);
    enable = true;
    # todo refactor terminal.nix to use common/wrap.nix
    extraConfig = builtins.readFile ./wezterm.lua;
  };

}
