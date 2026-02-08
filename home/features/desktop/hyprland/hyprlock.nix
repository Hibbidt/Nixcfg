
{config,lib,...}:
    with lib; let
    cfg = config.features.desktop.hyprland.hyprlock;
in
{
options.features.desktop.hyprland.hyprlock.enable = mkEnableOption "hyprlock config";

config = mkIf cfg.enable {
    programs.hyprlock = {
        enable = true;
    settings = {

  general = {
    hide_cursor = true;
    ignore_empty_input = true;
  };

  animations = {
    enabled = false;
    fade_in = {
      duration = 300;
      bezier = "easeOutQuint";
    };
    fade_out = {
      duration = 300;
      bezier = "easeOutQuint";
    };
  };

  background = [
    {
      path = "screenshot";
      blur_passes = 3;
      blur_size = 8;
    }
  ];

  input-field = [
    {
      size = "200, 50";
      position = "0, -80";
      monitor = "";
      dots_center = true;
      fade_on_empty = false;
      font_color = "rgb(202, 211, 245)";
      inner_color = "rgb(91, 96, 120)";
      outer_color = "rgb(24, 25, 38)";
      outline_thickness = 5;
      #placeholder_text = '\'<span foreground="##cad3f5">Password...</span>'\';
      shadow_passes = 2;
    }
  ];
};

    };
    };
}
