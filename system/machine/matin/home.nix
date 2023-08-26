{ config, pkgs, ... }:

{
  imports = [ ../../base/home.nix ];

  home.packages = with pkgs; [ docker-compose ];

  _module.args.email = "mail@hnaderi.dev";
  _module.args.sshKey = "E0C3F006EEBECE2F22AF32566C9212726A0768E4";
  _module.args.gpgKey = "F12968DFF08E271E";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
}
