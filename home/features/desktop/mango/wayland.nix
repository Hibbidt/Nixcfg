{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.desktop.mango.wayland;
in {
  options.features.desktop.mango.wayland.enable = mkEnableOption "wayland extra tools and config";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      qt6.qtwayland
      blueberry
      networkmanagerapplet
      wireplumber
      pwvucontrol
      brightnessctl
      wf-recorder
      wl-mirror
      wl-clipboard
      wtype
      ydotool
    ];
  };
}
