{ pkgs, extra ? [ ], ... }: {
  home.packages = with pkgs;
    [
      google-cloud-sdk
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
      # background code checker for rust
      bacon
      # caches rust deps so we don't recompile everytime
      sccache
      # cli for crates.io
      cargo-info
      # cli to manage talos linux nodes
      talosctl
      # kubernetes tools
      kubectl
      k9s
      kustomize
      kubernetes-helm
      kind
      stern
      # C compiler for bpf and other things
      clang
      strace
      # install cilium for homelab cni
      cilium-cli
      jq
      yq-go
      # diagrams
      drawio
    ] ++ extra;
}
