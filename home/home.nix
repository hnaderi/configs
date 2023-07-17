{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [ ./home/git.nix ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hnaderi";
  home.homeDirectory = "/home/hnaderi";

  home.packages = with pkgs; [
    jq
    ripgrep
    killall
    bc
    nethogs
    wget
    pwgen
    autojump

    zip
    unzip
    unrar
    ark

    # (tomb.override { pinentry = pkgs.pinentry-gtk2; })
    diceware

    sshuttle

    fd
    shellcheck
    rnix-lsp
    nixfmt

    # Spell checking
    ispell
    aspell
    aspellDicts.fa
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    tdesktop
    skypeforlinux
    element-desktop

    ntfs3g

    yakuake

    hledger
    hledger-ui
    ledger

    libreoffice

    inkscape
    gimp
    okular
    kcalc
    sublime3
    calibre
    spotify

    ffmpeg-full
    vlc
    gwenview

    # Fonts
    ## Farsi
    samim-fonts
    vazir-fonts
    shabnam-fonts
    sahel-fonts
    parastoo-fonts

    # English
    fira
    fira-code

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

  programs.firefox.enable = true;
  programs.chromium.enable = true;
  programs.browserpass.enable = true;
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-tomb ]);
  };

  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "9B581799742D880ECDFBA8EF753064D952BCEFBA" ];
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  programs.rofi = {
    enable = true;
    theme = "purple";
    terminal = "${pkgs.konsole}/bin/konsole";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.htop = { enable = true; };

  programs.tmux = { enable = true; };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    history.extended = true;
    shellAliases = {
      fa2en = "sed -e 'y/۰۱۲۳۴۵۶۷۸۹/0123456789/'";
      ".." = "cd ..";
      clip = "${pkgs.xclip}/bin/xclip -se c";
    };
    oh-my-zsh = {
      enable = true;
      theme = "nicoulaj";
      plugins = [
        "git"
        "gitignore"
        "sudo"
        "pass"
        "man"
        "rsync"
        "sbt"
        "scala"
        "systemd"
        "autojump"

        "terraform"

        "kubectl"
        "helm"
      ];
    };
    # initExtra = "export HTTP_PROXY=http://rpi4:8889 HTTPS_PROXY=http://rpi4:8889";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.aria2 = {
    enable = true;
    settings = {
      continue = true;
      log-level = "warn";
    };
  };

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
