{ config, lib, pkgs, ... }:

with lib;

{
  options = {

    services.warp-proxy = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = lib.mdDoc ''
          Whether to run cloudflare warp.
        '';
      };

      package = mkOption {
        type = types.package;
        default = pkgs.cloudflare-warp;
        defaultText = literalExpression "pkgs.cloudflare-warp";
        description = lib.mdDoc ''
          Which cloudflare-warp package to use.
        '';
      };

      internalPort = mkOption {
        type = types.port;
        default = 40000;
        description = lib.mdDoc "Internal proxy port";
      };
    };

  };

  config = let
    cfg = config.services.warp-proxy;
    internalPort = toString cfg.internalPort;
    cli = "${cfg.package}/bin/warp-cli";

  in mkIf cfg.enable {
    systemd.packages = [ cfg.package ];

    systemd.services.warp-proxy = {
      wantedBy = [ "multi-user.target" ];
      requires = [ "warp-svc.service" ];
      after = [ "warp-svc.service" ];
      description = "Connect to warp proxy";
      script = ''
        ${cli} --accept-tos register
        ${cli} --accept-tos set-proxy-port ${internalPort}
        ${cli} --accept-tos set-mode proxy
        ${cli} --accept-tos disable-dns-log
        ${cli} --accept-tos connect
      '';

    };
  };
}
