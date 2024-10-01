{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
  mkMachine = confPath:
    nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [ confPath ../system/configuration.nix ];
    };
in {
  behemoth = mkMachine ../system/machine/behemoth;
}
