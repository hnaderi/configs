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

      modules = [
        { inherit imports; }
        ../home/base
        {
          nix.registry.nixpkgs.flake = nixpkgs;
          home.sessionVariables.NIX_PATH =
            "nixpkgs=flake:nixpkgs\${NIX_PATH:+:$NIX_PATH}";
        }
      ];
    });

in {
  hnaderi = mkHome [ ../home/personal.nix ];
  matin = mkHome [ ../home/office.nix ];
}
