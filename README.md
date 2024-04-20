# serena's nix/home-manager stuff

I'm tired of setting my machines by hand all the time.

These are personal configs, but feel free to crib them for your nix stuff.

## Install

1. [install nix](https://nixos.org/download/)
2. [enable flakes](https://nixos.wiki/wiki/Flakes)
3. [bootstrap home-manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
4. clone this repo
5. copy desktop as a starting point
6. make changes as needed
7. `home-manager switch --flake .`

## To-dos

- unify desktop and xps-15 configs
- migrate mac configs to flakes
- figure out how to make work specific config private
