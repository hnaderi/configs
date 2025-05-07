{ config, lib, pkgs, ... }:

let
  mkScript = name: pkgs.writeScriptBin name (builtins.readFile ./${name}.sh);

  dprox = mkScript "dprox";

  kooshta = ./killed.wav;
  zebh = pkgs.writeScriptBin "zebh" ''
    #!/usr/bin/env sh

    pkill "$@" && ${pkgs.alsa-utils}/bin/aplay -q ${kooshta}
    exit $?
  '';

in { home.packages = [ zebh dprox ]; }
