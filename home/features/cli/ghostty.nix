{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.ghostty;
in {
  options.features.cli.ghostty.enable = mkEnableOption "enable and configure ghostty";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ghostty];

    programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
      systemd.enable = true;

      settings = {
        # theme = "catppuccin-mocha";
        font-size = 16;
        gtk-single-instance = false;

        keybind = [];
      };
    };
  };
}
