# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "M800"; # Define your hostname.
  #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking = {
  #   nameservers = [ "8.8.8.8" "1.1.1.1" ];
  #   networkmanager.enable = true;
  #   networkmanager.dns =
  #     lib.mkForce "none"; # networkmaneger not to overwrite /etc/resolv.conf
  # };

  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    # If using dhcpcd:
    dhcpcd.extraConfig = "nohook resolv.conf";
    # If using NetworkManager:
    networkmanager.enable = true;
    networkmanager.dns = "none";
    extraHosts = ''
      192.168.1.14    rpi4
      192.168.1.2     rpizw
    '';
  };
  # https://github.com/NixOS/nixpkgs/issues/61230
  services.resolved.enable = lib.mkForce false; # just to be sure
  environment.etc."resolv.conf" = {
    text = lib.optionalString (config.networking.nameservers != [ ])
      (lib.concatMapStrings (ns: ''
        nameserver ${ns}
      '') config.networking.nameservers);
    mode = "0444";
  };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp1s0.useDHCP = true;

  # nix.package = pkgs.nixUnstable;

  networking.firewall.allowedTCPPorts = [ 1716 22000 ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "Asia/Tehran";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #  environment.systemPackages = with pkgs; [
  #    wget vim ffmpeg vlc firefox
  #  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ir";
  services.xserver.xkbOptions = "grp:shifts_toggle,caps:ctrl_modifier";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.digimend.enable = true;

  services.xserver.inputClassSections = [
    ''
      Identifier "XP-Pen 9 inch PenTablet"
      MatchUSBID "28bd:0918"
      MatchIsTablet "on"
      MatchDevicePath "/dev/input/event*"
      Driver "wacom"
    ''
    ''
      Identifier "XP-Pen 9 inch PenTablet"
      MatchUSBID "28bd:0918"
      MatchIsKeyboard "on"
      MatchDevicePath "/dev/input/event*"
      Driver "libinput"
    ''
  ];

  services.udev.extraHwdb = ''
    evdev:input:b0003v28BDp0918e0100-e0*
      KEYBOARD_KEY_d0044=0x14c
      KEYBOARD_KEY_7002c=0x2
      KEYBOARD_KEY_700e2=0x3
      KEYBOARD_KEY_70008=0x4
      KEYBOARD_KEY_70005=0x5
  '';

  programs.adb.enable = true;
}
