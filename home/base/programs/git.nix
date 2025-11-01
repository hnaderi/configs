{ config, lib, pkgs, email, gpgKey, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Hossein Naderi";
        email = email;
      };
      init = { defaultBranch = "main"; };
    };
    signing = {
      key = gpgKey;
      signByDefault = true;
    };

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
    lfs.enable = true;
  };
}
