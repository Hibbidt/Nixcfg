{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.coding.python;
in {
  options.features.coding.python.enable = mkEnableOption "enable python language";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.python314.withPackages (
        pypkgs:
          with pypkgs; [
            numpy
            scipy
            matplotlib
            pyqt6
          ]
      ))
    ];
  };
}
