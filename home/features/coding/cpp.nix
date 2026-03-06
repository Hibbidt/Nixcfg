{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.coding.cpp;
in {
  options.features.coding.cpp.enable = mkEnableOption "enable cpp language";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
    ];
  };
}
