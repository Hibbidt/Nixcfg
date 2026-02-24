{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.anki;
in {
  options.features.desktop.anki.enable = mkEnableOption "anki config";

  config = mkIf cfg.enable {
    programs.anki = {
      enable = true;
      theme = "dark";
      spacebarRatesCard = true;
      reduceMotion = true;
    };
  };
}
