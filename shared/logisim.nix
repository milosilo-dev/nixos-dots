{ pkgs, ... }:

let
  logisim-evolution = pkgs.logisim-evolution.overrideAttrs (finalAttrs: prevAttrs: {
    version = "5.0.0";
    src = pkgs.fetchurl {
      url = "https://github.com/logisim-evolution/logisim-evolution/releases/download/v${finalAttrs.version}/logisim-evolution-${finalAttrs.version}-all.jar";
      hash = "sha256-azaOiUdCwEzIOqmDD4abyrAZDt5N9DrW/s24mzojpBw=";
    };
    postInstall = (prevAttrs.postInstall or "") + ''
      wrapProgram $out/bin/logisim-evolution --set _JAVA_AWT_WM_NONREPARENTING 1
    '';
  });
in
{
  environment.systemPackages = [ logisim-evolution ];
}
