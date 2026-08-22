{ lib, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'niri-session'";
      user = "greeter";
    };
  };

  systemd.services.greetd = {
    after = [ "local-fs.target" ];
    wants = [];
  };
}