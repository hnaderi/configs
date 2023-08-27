{ config, lib, pkgs, ... }:

let
  mkScript = name: pkgs.writeScriptBin name (builtins.readFile ./${name}.sh);

  zebh = mkScript "zebh";
  dprox = mkScript "dprox";
in { home.packages = [ zebh dprox ]; }
