{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.cli.tealdeer;
in
{
  options.features.cli.tealdeer.enable = mkEnableOption "enable tealdeer";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ tealdeer ];

    programs.tealdeer = {
      enable = true;
      enableAutoUpdates = true;

      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = true;
          auto_update_interval_hours = 720;
        };
      };
    };
  };
}
