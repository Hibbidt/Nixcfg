{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.mango.quickshell;
in {
  options.features.desktop.mango.quickshell.enable = mkEnableOption "quickshell options";

  config = mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
    };
  };
}
