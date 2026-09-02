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
     gcc
     opencode
     
     # Touch ID
     fprintd

     # Rusty stuff
     cargo
     rustup
  ];
}