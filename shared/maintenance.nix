{ pkgs, ... }:
{
    systemd.services.system-maintenance = {
        description = "NixOS system maintenance";

        after = [ "multi-user.target" ];

        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.bash}/bin/bash ${../maintenance.sh}";
            User = "root";
            Environment = "PATH=${pkgs.nix}/bin:${pkgs.coreutils}/bin:${pkgs.gawk}/bin";
        };
    };

    systemd.timers.system-maintenance = {
        wantedBy = [ "timers.target" ];

        timerConfig = {
            OnCalendar = "weekly";
            Persistent = true;
            RandomizedDelaySec = "30min";
        };
    };
}