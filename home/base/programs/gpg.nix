{ config, lib, pkgs, sshKey, ... }:

{
  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ sshKey ];
    pinentryFlavor = "qt";
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
