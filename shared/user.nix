{ lib, pkgs, mainUser, ... }:
{
  users.users."${mainUser}" = {
    isNormalUser = true;
    description = "Miles Hansell";
    extraGroups = [ "networkmanager" "wheel" "input" "video" "render" ];
    shell = pkgs.zsh;
    packages = with pkgs; [];
  };
}