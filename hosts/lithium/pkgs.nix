{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
     neovim
     git
     brave
     alacritty
     noctalia-shell
     fastfetch
     pokemon-colorscripts
     fzf
     evtest
     vscode
     btop
     upower
     gh
     usbutils

     # Touch ID
     fprintd

     # Rusty stuff
     cargo
     rustup

     # Ferrum vm
     pkgsCross.i686-embedded.buildPackages.gcc
  ];
}