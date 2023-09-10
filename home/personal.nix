{ config, pkgs, ... }:

{
  _module.args.email = "hossein-naderi@hotmail.com";
  _module.args.sshKey = "9B581799742D880ECDFBA8EF753064D952BCEFBA";
  _module.args.gpgKey = "EDCDD60BA926A748";

  home.packages = with pkgs; [
    skypeforlinux
    element-desktop

    hledger
    hledger-ui
    ledger

    calibre
    spotify

    docker-compose
    kubectl
    kubernetes-helm

    wireshark

    dbeaver

    python3
    nodejs_latest

    webcamoid
    zeroad
  ];

  programs.chromium.enable = true;

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  services.syncthing = { enable = true; };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";
}