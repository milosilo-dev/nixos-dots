{ inputs, config, pkgs, stablePkgs, lib, hostname, mainUser, ... }:

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
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  
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
