{ pkgs, extra ? [ ], ... }: {
  home.packages = with pkgs;
    [
      # terminal multiplexer
      zellij
      # ls replacement
      eza
      htop
      # display images in terminal
      libsixel
      # serial console for raspberrypi / other mcus
      picocom
      # git tools and plugins
      git-branchless
      meld
      delta
      # container image explorer
      dive
      binutils
      # prompt
      starship
      # install rust tools
      rustup
      # cat replacement
      bat
      lldb
      # needed for helix clipboard
      wl-clipboard-x11
      # grep replacement
      ripgrep
      # fuzzy finder
      fzf
    ] ++ extra;
}
