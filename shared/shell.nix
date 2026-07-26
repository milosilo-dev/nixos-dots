{ lib, hostname, mainUser, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
	    nrs = "sudo nixos-rebuild switch --flake /home/${mainUser}/system#" + hostname;
    };

    interactiveShellInit = ''
      fastfetch -c ~/.config/fastfetch/config-pokemon.jsonc
    '';

    # Oh My Zsh configuration
    ohMyZsh = {
      enable = true;
      theme = "robbyrussell"; # Or "agnoster", "powerlevel10k/powerlevel10k", etc.
      plugins = [
        "git"
        # Add other plugins here
      ];
    };
  };
}