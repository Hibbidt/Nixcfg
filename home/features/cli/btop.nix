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
        theme_background = true;
        show_boxes = "proc cpu mem net";
        update_ms = 5000;
        proc_sorting = "cpu lazy";
        proc_color = true;
        proc_mem_bytes = true;
        truecolor = true;
        show_cpu_watts = true;
        check_temp = true;
        show_update = true;
        base_10_sizes = false;
        show_cpu_freq = true;
        temp_scale = "celsius";
        show_battery = true;
        selected_battery = "BAT1";
        net_auto = true;
      };
    };
  };
}
