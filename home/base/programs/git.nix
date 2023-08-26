{ config, lib, pkgs, email, gpgKey, ... }:

{
  programs.git = {
    enable = true;
    userName = "Hossein Naderi";
    userEmail = email;
    signing = {
      key = gpgKey;
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
