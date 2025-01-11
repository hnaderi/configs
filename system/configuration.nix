# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  virtualisation.docker = {
    enable = true;
    liveRestore = false;
  };

  users.extraGroups.vboxusers.members = [ "hnaderi" ];

  services = {
    tor = {
      enable = true;
      client.enable = true;
    };
    privoxy = {
      enable = true;
      enableTor = true;
    };
  };

  programs.zsh.enable = true;
  programs.wireshark.enable = true;

  users.users.hnaderi = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "docker" "adbusers" "vboxusers" "dialout" "wireshark" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  # Nix daemon config
  nix = {
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 30d";
    };

    # Flakes settings
    # package = pkgs.nixVersions.stable;
    package = pkgs.nixVersions.latest;
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=flake:nixpkgs" ];

    settings = {
      # Automate `nix store --optimise`
      auto-optimise-store = true;

      # Required by Cachix to be used as non-root user
      trusted-users = [ "root" "hnaderi" ];

      experimental-features = [ "nix-command" "flakes" ];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    };
  };
}
