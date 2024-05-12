{ pkgs, system, nixGL, lib, input_package, ... }:
pkgs.runCommand "${input_package.name}-nixgl-wrapper" { } ''
  mkdir $out
  ln -s ${input_package}/* $out
  rm $out/bin
  mkdir $out/bin
  for bin in ${input_package}/bin/*; do
   wrapped_bin=$out/bin/$(basename $bin)
   echo "exec ${
     lib.getExe nixGL.packages.${system}.nixGLIntel
   } $bin \$@" > $wrapped_bin
   chmod +x $wrapped_bin
  done
''
