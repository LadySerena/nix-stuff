builtins.map (f: ../common + "/${f}") (
  builtins.attrNames (builtins.removeAttrs (builtins.readDir ./.) [ "default.nix" ])
)
