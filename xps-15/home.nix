{ pkgs, system, helix-nightly, nixGL, lib, ... }:
let
  wrap = input_package:
    (import ../common/wrap.nix ({
      inherit pkgs system nixGL lib input_package;
    }));

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kitty";
  home.homeDirectory = "/home/kitty";

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
    (import ../common/packages.nix ({
      pkgs = pkgs;
      extra = [ (wrap pkgs.rpi-imager) ];
    }))
  ] ++ import ../common;

  programs.helix = {
    enable = true;
    package = helix-nightly.packages.${system}.default;
  };

  programs.wezterm = {
    package = (wrap pkgs.wezterm);
    enable = true;
    extraConfig = builtins.readFile ../wezterm.lua;
  };

  programs.gh = {
    enable = true;

    settings = {
      # Workaround for https://github.com/nix-community/home-manager/issues/4744
      version = 1;
    };
  };
}
