{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.coding.qml;
in {
  options.features.coding.qml.enable = mkEnableOption "enable qml language";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtbase
      qt6.qttools
      qt6.qtwayland
      qt6.qtdeclarative
    ];
  };
}
