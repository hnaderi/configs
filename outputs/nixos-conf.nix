{ inputs, system, ... }:

let nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in {
  m800 = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [ ../system/machine/m800 ../system/configuration.nix ];
  };
}
