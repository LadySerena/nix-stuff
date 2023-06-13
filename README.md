# serena's nix/home-manager stuff

I'm tired of setting my machines by hand all the time so like a basic transfemme let's finally learn nix.

## install

1. install nix
  * https://nixos.org/download.html
  * `sh <(curl -L https://nixos.org/nix/install) --daemon`
2. https://github.com/nix-community/home-manager
  * install home manager
3. clone this repo
4. symlink `home.nix` to `~/.config/home-manager/home.nix`
5. install the things with `home-manager switch`
