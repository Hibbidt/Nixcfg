{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.WM.quickshell;
in {
  options.features.desktop.WM.quickshell.enable = mkEnableOption "quickshell options";

  config = mkIf cfg.enable {
    programs.quickshell = {
      enable = true;
    };
  };
}
