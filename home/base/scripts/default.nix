{ config, lib, pkgs, ... }:

let
  mkScript = name: pkgs.writeScriptBin name (builtins.readFile ./${name}.sh);

  dprox = mkScript "dprox";
  zebh = pkgs.writeScriptBin "zebh" ''
    #!/usr/bin/env sh

    pkill "$@" && ${pkgs.alsa-utils}/bin/aplay -q ${./killed.wav}
    exit $?
  '';

in { home.packages = [ zebh dprox ]; }
