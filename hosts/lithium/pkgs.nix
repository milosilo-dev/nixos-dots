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

     # Rusty stuff
     cargo
     rustup
  ];
}