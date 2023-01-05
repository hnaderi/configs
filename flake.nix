{
  description = "hnaderi's Home Manager & NixOS configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let system = "x86_64-linux";
    in {
      homeConfigurations =
        (import ./outputs/home-conf.nix { inherit inputs system; });

      nixosConfigurations =
        (import ./outputs/nixos-conf.nix { inherit inputs system; });
    };
}
