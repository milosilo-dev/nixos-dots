{ lib, mainUser, ... }:

let
  configFiles = [
    { 
      local = ../config/niri/config.kdl; 
      global = "/home/${mainUser}/.config/niri/config.kdl"; 
    }
    { 
      local = ../config/fastfetch/config.jsonc; 
      global = "/home/${mainUser}/.config/fastfetch/config.jsonc"; 
    }
    { 
      local = ../config/fastfetch/config-pokemon.jsonc; 
      global = "/home/${mainUser}/.config/fastfetch/config-pokemon.jsonc"; 
    }
    {
      local = ../config/zsh/.zshrc;
      global = "/home/${mainUser}/.zshrc";
    }
  ];
in {
  system.activationScripts.userConfigs.text =
    lib.concatMapStringsSep "\n" ({ local, global }: ''
      mkdir -p "$(dirname "${global}")"
      ln -sf ${local} "${global}"
      chown -h ${mainUser}:users "${global}"
    '') configFiles;
}