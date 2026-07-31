{ lib, fingerprintSensor, ... }: 
{
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = fingerprintSensor.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./calib-data.bin;
      };
    };
  };

  security.pam.services = {
    login.fprintAuth = true;
    greetd.fprintAuth = true;
  };
}