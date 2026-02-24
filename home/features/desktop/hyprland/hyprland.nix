{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.hyprland.hyprland;
in {
  options.features.desktop.hyprland.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        xwayland = {
          force_zero_scaling = true;
        };

        exec-once = [
          "waybar"
          "hyprpaper"
          "hypridle"
          "wl-paste --type  text --watch cliphist store" # -P --histpath=\"~/.local/share/clipman-primary.json\""
          "wl-paste --type image --watch cliphist store"
        ];

        env = [
          "XCURSOR_SIZE,32"
          "WLR_NO_HARDWARE_CURSORS,1"
          "GTK_THEME,Dracula"
        ];

        input = {
          kb_layout = "de";
          kb_variant = "";
          kb_model = "";
          kb_rules = "";
          kb_options = "lv3:caps_switch_capslock_with_ctrl";
          follow_mouse = 1;

          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 1;
          "col.active_border" = "rgba(9742b5ee) rgba(9742b5ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
          layout = "dwindle";
        };

        decoration = {
          shadow = {
            enabled = false;
            # "col.shadow" = "rgba(1E202966)"; not working giving errors
          };
          rounding = 8;
          blur = {
            enabled = false;
            size = 3;
            passes = 3;
          };
          active_opacity = 0.9;
          inactive_opacity = 0.85;
        };

        animations = {
          enabled = false;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {};

        # gestures = { workspace_swipe = true; }; # old deprecated

        windowrule = [
          "match:float file_progress"
          "match:float confirm"
          "match:float dialog"
          "match:float download"
          "match:float notification"
          "match:float error"
          "match:float splash"
          "match:float confirmreset"
          "no_blur on, match:initial_class com.github.xournalpp.xournalpp"

          "match:class wlogout"
          "match:title wlogout"
          "match:class mpv"
          "match:float Open File"
          "match:float branchdialog"
          "match:float ^(Media viewer)$"
          "match:float ^(Volume Control)$"
          "match:float ^(Picture-in-Picture)$"
        ];

        "$mainMod" = "SUPER";
        "$terminal" = "ghostty";
        "$filemanager" = "dolphin";

        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];

        bind = [
          "$mainMod, t, exec, $terminal"
          "$mainMod, e, exec, $filemanager"
          "$mainMod, escape, exec, wlogout -p layer-shell"
          "$mainMod, Space, togglefloating"
          "$mainMod, q, killactive"
          "$mainMod, M, exit"
          "$mainMod, F, fullscreen"
          "ALT, SPACE, exec, rofi -show drun -file-browser-depth 0 -theme Arc-Dark -run-command"
          "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
          "$mainMod SHIFT, P, pseudo"

          "$mainMod, I, togglesplit"
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];
      };
    };
  };
}
