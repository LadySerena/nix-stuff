{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  nixpkgs.config.allowUnfree = true;

  imports = [ ./helix.nix ];
  # config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.htop
    pkgs.helix
    pkgs.starship
    pkgs.rustup
    pkgs.zellij
    pkgs.git
    pkgs.nil
    pkgs.gh
    pkgs.starship
    pkgs.bat
    pkgs.lldb
    pkgs.nodePackages.yaml-language-server
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.prettier
    pkgs.nodePackages.dockerfile-language-server-nodejs
    pkgs.ltex-ls
    pkgs.qemu
    pkgs.nixfmt
    pkgs.google-cloud-sdk
    pkgs.fzf

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.git = {
    enable = true;
    userName = "LadySerena";
    userEmail = "serena.tiede+github@gmail.com";
    aliases = {
      amend = "commit --all --amend --no-edit";
      new = "!f() { git checkout -b serena/$1; }; f";
      yeet =
        "!f() { git branch | grep -v ' master$' | grep -v ' main$' | xargs git branch -D; }; f";
    };
    extraConfig = {
      core = { editor = "hx"; };
      pull = { rebase = true; };
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      directory = { truncate_to_repo = false; };
      username = { show_always = true; };
      kubernetes = { disabled = false; };
    };
  };

  programs.fzf = { enable = true; };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kat/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = { EDITOR = "hx"; };

  programs.zsh = {
    enable = true;
    initExtra = ''
      . "$HOME/.cargo/env"
      bindkey "^[," backward-word
      bindkey "^[." forward-word
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };

  programs.gh = { enable = true; };

  programs.bat = {
    enable = true;
    config = { theme = "base16"; };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
