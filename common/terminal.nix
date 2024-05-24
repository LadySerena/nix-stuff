{
  programs.zsh = {
    enable = true;
    autosuggestion = { enable = true; };

    initExtra = ''
      bindkey "^[," backward-word
      bindkey "^[." forward-word
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      setopt interactivecomments
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    options = [ "--cmd=cd" ];
  };

  programs.zellij = {
    enable = true;
    settings = { pane_frames = false; };
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
}
