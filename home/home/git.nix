{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Hossein Naderi";
    userEmail = "hossein-naderi@hotmail.com";
    signing = {
      key = "EDCDD60BA926A748";
      signByDefault = true;
    };
    extraConfig = { init = { defaultBranch = "main"; }; };
    # ToDo
    ignores = [
      # Emacs
      ".dir-locals.el"
      ".litable-lists.el"
      "*.~undo-tree~"

      # Scala
      ".ensime"
      ".ensime_cache/"
      "ensime.sbt"
      ".sbt-hydra-history"
      ".metals"
      ".bloop"
      "/project/metals.sbt"
      "metals.sbt"
      ".bsp"
    ];
  };
}
