#!/usr/bin/env bash

CMD=$1
SVC="${2:-nix-daemon}"
PROXY_ENV="${http_proxy:-$HTTP_PROXY}"
PROXY="${PROXY_ENV:-localhost:9999}"

BASE_DIR=/run/systemd/system
SVC_DIR="$BASE_DIR/$SVC.service.d"
OVERRIDE_FILE="$SVC_DIR/proxy-override.conf"

log(){
    printf "Service\t: %s\n" "$SVC"
    printf "Proxy\t: %s\n" "$PROXY"
}

on() {
    echo Setting proxy...
    log;

    mkdir -p "$SVC_DIR"
    cat << EOF >"$OVERRIDE_FILE"
[Service]
Environment="http_proxy=$PROXY"
Environment="https_proxy=$PROXY"
Environment="all_proxy=$PROXY"
EOF

    reload
}

off() {
    echo Removing proxy...
    log;

    rm "$OVERRIDE_FILE"

    reload
}

reload() {
    systemctl daemon-reload
    systemctl restart "$SVC"
}

case $CMD in
    "on")
        on
        ;;
    "off")
        off
        ;;
    *)
        echo "Invalid arguments!";
        ;;
esac
