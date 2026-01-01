{ config, pkgs, ... }:
let
  freecad-fixed = pkgs.symlinkJoin {
    name = "freecad-wayland-fix";
    paths = [ pkgs.freecad-wayland ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/FreeCAD \
        --prefix MESA_LOADER_DRIVER_OVERRIDE : zink \
        --prefix __EGL_VENDOR_LIBRARY_FILENAMES : ${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json \
    '';
  };
  orca-slicer-fixed = pkgs.symlinkJoin {
    name = "orca-slicer-fix";
    paths = [ pkgs.orca-slicer ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/orca-slicer \
        --prefix GBM_BACKEND : dri \
    '';
  };

in {
  _module.args.email = "hossein-naderi@hotmail.com";
  _module.args.sshKey = "9B581799742D880ECDFBA8EF753064D952BCEFBA";
  _module.args.gpgKey = "EDCDD60BA926A748";

  home.packages = with pkgs; [
    teams-for-linux

    hledger
    hledger-ui
    ledger

    wireshark

    dbeaver-bin

    python3
    nodejs_latest
    clang-tools
    semgrep
    platformio

    webcamoid

    freecad-fixed
    orca-slicer-fixed
    kicad-small

    openrgb

    v2raya
    xray
    v2ray
    pingtunnel

    zeroad
  ];

  programs.chromium.enable = true;

  services.kdeconnect = { enable = true; };

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
