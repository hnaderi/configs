{ inputs, system, ... }:

with inputs;

let

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  mkHome = imports:
    (home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [{ inherit imports; }];
    });

in {
  hnaderi = mkHome [ ../home/home.nix ];
  matin = mkHome [ ../system/machine/matin/home.nix ];
}
