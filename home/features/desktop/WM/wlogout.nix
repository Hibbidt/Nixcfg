{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.WM.wlogout;
in {
  options.features.desktop.WM.wlogout.enable = mkEnableOption "wlogout config";

  config = mkIf cfg.enable {
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Shutdown";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
        }
      ];
    };
  };
}
