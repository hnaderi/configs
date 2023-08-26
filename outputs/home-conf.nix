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

      modules = [ { inherit imports; } ../home/base ];
    });

in {
  hnaderi = mkHome [ ../home/personal.nix ];
  matin = mkHome [ ../home/office.nix ];
}
