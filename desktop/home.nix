{ config, pkgs, system, helix-nightly, nixGL, git-branchless, lib, ... }:
let
  nixGLWrap = pkg:
    pkgs.runCommand "${pkg.name}-nixgl-wrapper" { } ''
      mkdir $out
      ln -s ${pkg}/* $out
      rm $out/bin
      mkdir $out/bin
      for bin in ${pkg}/bin/*; do
       wrapped_bin=$out/bin/$(basename $bin)
       echo "exec ${
         lib.getExe nixGL.packages.${system}.nixGLIntel
       } $bin \$@" > $wrapped_bin
       chmod +x $wrapped_bin
      done
    '';

in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "serena";
  home.homeDirectory = "/home/serena";

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

  imports = [ ../helix.nix ../personal-git.nix ];

  home.packages = with pkgs; [
    zellij
    eza
    htop
    libsixel
    picocom
    meld
    delta
    dive
    binutils
    starship
    rustup
    bat
    lldb
    # idk why 0.8 in nixpkgs doesn't build but use flake for now
    git-branchless.packages.${system}.default
    # needed for helix clipboard
    wl-clipboard-x11
  ];

  programs.helix = {
    enable = true;
    package = helix-nightly.packages.${system}.default;
  };

  programs.wezterm = {
    package = (nixGLWrap pkgs.wezterm);
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

  programs.starship = {
    enable = true;
    settings = {
      command_timeout = 1500;
      directory = { truncate_to_repo = false; };
      username = { show_always = true; };
      kubernetes = { disabled = false; };
    };
  };

  programs.zsh = {
    enable = true;
    initExtra = ''
      . "$HOME/.cargo/env"
      bindkey "^[," backward-word
      bindkey "^[." forward-word
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      setopt interactivecomments
    '';
  };
}
