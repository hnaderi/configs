{ config, lib, pkgs, ... }:

let clip = "${pkgs.xclip}/bin/xclip -se c";
in {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    history.extended = true;
    shellAliases = {
      fa2en = "sed -e 'y/۰۱۲۳۴۵۶۷۸۹/0123456789/'";
      ".." = "cd ..";
      inherit clip;
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
        "poetry"
        "systemd"
        "autojump"

        "terraform"

        "kubectl"
        "helm"
      ];
    };
    localVariables = { EDITOR = "vim"; };
    initExtra = ''
      newpass(){
        LENGTH=''${1:-50};
        pwgen -sy "$LENGTH" 1 | ${clip};
      }
    '';
  };
}
