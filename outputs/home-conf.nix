{ inputs, system, ... }:

with inputs;

let

  pkgs = import nixpkgs {
    inherit system;

    config.allowUnfree = true;
  };

  imports = [ ../home/home.nix ];

in {
  hnaderi = (home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [{ inherit imports; }];
  });

  matin = (home-manager.lib.homeManagerConfiguration {
    inherit pkgs;

    modules = [{ imports = [ ../system/machine/matin/home.nix ]; }];
  });
}
