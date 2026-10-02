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
     nmap
     orca-slicer
     zed-editor
     gnome-control-center
     prismlauncher
     xwayland-satellite
     gcc
     opencode
     file
     
     # Touch ID
     fprintd

     # Rusty stuff
     cargo
     rustup

     proton-vpn
  ];
}