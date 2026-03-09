{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.nix-output-monitor;
in {
  options.features.cli.nix-output-monitor.enable = mkEnableOption "enable nix-output-monitor";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nix-output-monitor
    ];

    programs.nix-your-shell.nix-output-monitor = {
      enable = true;
    };
  };
}
