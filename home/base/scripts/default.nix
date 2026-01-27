{ config, lib, pkgs, ... }:

let
  mkScript = name: pkgs.writeScriptBin name (builtins.readFile ./${name}.sh);

  dprox = mkScript "dprox";
  zebh = pkgs.writeScriptBin "zebh" ''
    #!/usr/bin/env sh

    pkill "$@" && ${pkgs.alsa-utils}/bin/aplay -q ${./killed.wav}
    exit $?
  '';
  myip = pkgs.writeScriptBin "myip"
    "curl --silent http://ip-api.com/json/ | ${pkgs.jq}/bin/jq .";

in { home.packages = [ zebh dprox myip ]; }
