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

     # Rusty stuff
     cargo
     rustup
  ];
}