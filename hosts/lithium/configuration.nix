{ inputs, config, pkgs, stablePkgs, lib, hostname, mainUser, nixos-boot, ... }:

let
  theme = "load_unload";
  delay = "4";
in
{
  imports =
    [
      ./hardware-configuration.nix
      ./pkgs.nix
      ../../shared/greetd.nix
      ../../shared/shell.nix
      ../../shared/local.nix
      ../../shared/sound.nix
      ../../shared/user.nix
      ../../shared/activate.nix
      ../../shared/maintenance.nix
      ../../shared/virt-manager.nix
      ../../shared/hyprlock.nix
    ];

  nixos-boot = {
    enable  = true;
  };

  boot.plymouth = {
    enable = true;
    theme = theme;
  };

  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.kernelParams = [ "pm_print_times=1" "pm_debug_messages=1" ];
  boot.blacklistedKernelModules = [
    "cdc_mbim" "cdc_ncm" "cdc_wdm" "cdc_acm" "cdc_ether" "usbnet" "qrtr"
  ];

  services.gnome.evolution-data-server.enable = true;
  programs.dconf.enable = true;

  programs.niri.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  system.stateVersion = "26.05";
}
