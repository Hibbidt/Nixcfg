{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.nh;
in {
  options.features.cli.nh.enable = mkEnableOption "enable nh";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [nh];

    programs.nh = {
      enable = true;
      flake = "/home/${config.home.username}/Nixcfg/";
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 5d --keep 7";
      };
    };
  };
}
