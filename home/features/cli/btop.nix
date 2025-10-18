
{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.btop;
in {
options.features.cli.btop.enable = mkEnableOption "enable btop";

config = mkIf cfg.enable {
home.packages = with pkgs; [btop];

programs.btop = {
    enable = true;
    settings = {
        color_theme = "Default";
        theme_background = true;
        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        graph_symbol = "brasile";
        graph_symbol_cpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";
        show_boxes = "proc cpu mem net";
        update_ms = 5000;
        proc_sorting = "cpu lazy";
        proc_color = true;
        proc_mem_bytes = true;
        cpu_graph_upper = "total";
        truecolor = true;
        show_cpu_watts = true;
        check_temp = true;
        show_update = true;
        base_10_sizes = false;
        show_cpu_freq = true;
        temp_scale = "celsius";
        show_battery= true;
        selected_battery= "Auto";
        net_auto = true;


        };

};
};
}
