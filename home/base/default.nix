{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports =
    [ ./programs/zsh.nix ./programs/git.nix ./programs/gpg.nix ./scripts ];
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
    dig
    nvitop
    s-tui

    zip
    unzip
    unrar
    ark

    # (tomb.override { pinentry = pkgs.pinentry-gtk2; })
    diceware
    git-crypt

    sshuttle

    fd
    shellcheck
    nixd
    nixfmt-classic
    yaml-language-server

    docker-compose
    kubectl
    kubernetes-helm

    # Spell checking
    ispell
    aspell
    aspellDicts.fa
    aspellDicts.en
    aspellDicts.en-computers
    aspellDicts.en-science

    tdesktop

    ntfs3g

    yakuake

    libreoffice

    inkscape
    gimp
    okular
    kcalc
    gedit

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
  ];

  programs.firefox.enable = true;
  programs.browserpass.enable = true;
  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp exts.pass-tomb ]);
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
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
  programs.btop = {
    enable = true;
    settings = { color_theme = "HotPurpleTrafficLight"; };
  };

  programs.tmux = { enable = true; };

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

  services.syncthing = { enable = true; };

  nix = {
    gc = {
      automatic = true;
      frequency = "monthly";
      options = "--delete-older-than 30d";
    };
  };
}
