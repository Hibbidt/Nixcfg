{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.starship;
in {
  options.features.cli.starship.enable = mkEnableOption "enable starship";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [starship];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
