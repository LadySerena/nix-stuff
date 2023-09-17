{ config, pkgs, lib, ... }:
let
  # ...
  nixgl = import <nixgl> { };
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';
in {

  imports = [ ./common.nix ./personal-git.nix ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config.allowUnfree = true;
  # config.allowUnfree = true;
  home.username = "serena";
  home.homeDirectory = "/home/serena";
  home.packages = [
    nixgl.auto.nixGLDefault
    (nixGLWrap pkgs.wezterm)
    pkgs.lima

  ];

  programs.wezterm = {
    enable = true;
    package = nixGLWrap pkgs.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;

  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

}
