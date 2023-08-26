{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [ ./programs/git.nix ./programs/gpg.nix ];
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

    ntfs3g

    yakuake

    libreoffice

    inkscape
    gimp
    okular
    kcalc

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

  services.syncthing = { enable = true; };
}
