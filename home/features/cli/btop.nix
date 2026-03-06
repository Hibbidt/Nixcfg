{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.btop;
in {
  options.features.cli.btop.enable = mkEnableOption "enable btop";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [btop];

    programs.btop = {
      enable = true;
      settings = {
        base_10_sizes = false;
        check_temp = true;
        cpu_sensors = "Auto";
        net_auto = true;
        proc_color = true;
        proc_mem_bytes = true;
        proc_sorting = "cpu lazy";
        selected_battery = "Auto";
        show_battery = true;
        show_battery_watts = true;
        show_boxes = "proc cpu mem net";
        show_cpu_freq = true;
        show_cpu_watts = true;
        show_update = true;
        temp_scale = "celsius";
        theme_background = true;
        truecolor = true;
        update_ms = 5000;
      };
    };
  };
}
