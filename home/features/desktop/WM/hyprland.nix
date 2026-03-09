{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.desktop.WM.hyprland;
in
{
  options.features.desktop.WM.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      grim
      hyprlock
      qt6.qtwayland
      slurp
      blueberry
      networkmanagerapplet
      wireplumber
      brightnessctl
      wf-recorder
      wl-mirror
      wl-clipboard
      wlogout
      wtype
      ydotool
    ];

    programs.wlogout = {
      layout = mkOrder 50 [
        {
          label = "lock";
          action = "hyprlock";
          text = "Lock";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "Logout";
        }
      ];
    };

    programs.waybar = {
      enable = true;

      style = ''
                * {
        border: none;
                border-radius: 0;
                font-family: "JetBrainsMono Nerd Font";
                font-weight: bold;
                font-size: 16px;
                min-height: 0;
                }

              window#waybar {
        background: rgba(21, 18, 27, 0);
        color: #f6f7fc;
        }


              tooltip {
        background: #1e1e2e;
        opacity: 0.8;
                 border-radius: 10px;
                 border-width: 2px;
                 border-style: solid;
                 border-color: #11111b;
              }

              tooltip label{
        color: #cdd6f4;
              }

        #workspaces button {
        padding: 5px;
        color: #f6f7fc;
               margin-right: 5px;
        }

        #workspaces button.active {
        color: #000000;
        background: #a6e3a1;
                    border-radius: 12px;
        }

        #workspaces button:hover {
        background: #11111b;
        color: #cdd6f4;
               border-radius: 10px;
        }

        #window,
        #cpu,
        #disk,
        #memory,
        #clock,
        #battery,
        #network,
        #tray,
        #temperature,
        #hyprland-workspaces,
        #ext-workspaces,
        #idle_inhibitor,
        #custom-lock_screen,
        #custom-power_btn,
        #custom-launch_rofi,
        #pulseaudio,

        #backlight {
        background: rgba(21, 18, 27, 0);
        opacity: 1;
        padding: 0px 8px;
        margin: 0px 3px;
        border: 0px;
        }

        #temperature.critical {
        color: #e92d4d;
        }

        #workspaces {
          padding-right: 0px;
          padding-left: 5px;
        }

        #window {
          border-radius: 10px;
          margin-left: 0px;
          margin-right: 0px;
        }

      '';

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          "gtk-layer-shell" = true;
          height = 22;

          modules-left = [
          ];

          modules-center = [
          ];

          modules-right = [
          ];

          "custom/power_btn" = {
            format = "";
            on-click = "sh -c '(sleep 0.25s; wlogout --protocol layer-shell)' & disown";
            tooltip = false;
          };

          "ext/workspaces" = {
            format = "{name} {icon}";
            on-click = "activate";
            on-click-right = "deactivate";
            sort-by-id = true;
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
            };
          };

          memory = {
            interval = 30;
            format = "";
            max-length = 10;
            tooltip = true;
            tooltip-format = "Memory - {used:0.1f}GB used ({percentage}%)\nSwap - {swapUsed:0.1f}GB used {swapPercentage}%";
          };

          network = {
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format = "{icon}";
            format-wifi = "{icon}";
            format-ethernet = "󰀂";
            format-disconnected = "󰤮";
            tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}\n IP: {ipaddr}";
            tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}\n IP: {ipaddr}";
            tooltip-format-disconnected = "Disconnected";
            interval = 10;
            spacing = "1";
            on-click = "nm-applet";
          };

          bluetooth = {
            on-click = "blueberry";
            format = "";
            format-disabled = "󰂲";
            format-connected = " {num_connections}";
            tooltip-format = "({controller_alias})\t{controller_address} {num_connections} connected";
            tooltip-format-connected = "({controller_alias})\t({controller_address})\n({num_connections} connected)\n{device_enumerate}";
            tooltip-format-enumerate-connected = "({device_alias})\t{device_address}";
            tooltip-format-enumerate-connected-battery = "({device_alias})\t({device_address})\t{device_battery_percentage}%";
          };

          clock = {
            format = "{:%R}";
            format-alt = "{:%A, %B %d, %Y (%T)}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };

          "custom/launch_rofi" = {
            format = " ";
            max-length = 10;
            on-click = "sh -c '(sleep 0.25s; pkill rofi || rofi -show combi -modes combi -combi-modes \"window,drun\" -show-icons -theme fullscreen-preview)' & disown";
            tooltip = false;
          };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "󰛐";
              deactivated = "󰛑";
            };
            tooltip = true;
          };

          "custom/lock_screen" = {
            format = "";
            on-click = "sh -c '(sleep 0.25s; hyprlock)' & disown";
            tooltip = false;
          };

          "hyprland/workspaces" = {
            format = "{name} {icon}";
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
              "8" = "";
            };
            persistent_workspaces = {
              "*" = 4;
            };
          };

          battery = {
            format = "{capacity}% {icon}";
            format-discharging = "{icon}";
            format-charging = "{icon}";
            format-plugged = "";
            format-icons = {
              charging = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              default = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            format-full = "󰂅";
            tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}% {cycles} ({health}%)\n {timeTo}";
            tooltip-format-charging = "{power:>1.0f}W↑ {capacity}% {cycles} ({health}%)\n {timeTo}";
            interval = 10;
            states = {
              warning = 20;
              critical = 10;
            };
          };
          cpu = {
            interval = 10;
            format = "";
            max-length = 10;
            format-alt-click = "click-right";
            format-alt = " {usage}%";
            on-click = "ghostty --fullscreen --title=btop -e btop";
          };

          temperature = {
            format = "{icon}";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = true;
            tooltip-format = "{temperatureC}°C";
            format-alt-click = "click-right";
            format-alt = "{icon}{temperatureK}K";
          };

          pulseaudio = {
            format = "{icon}";
            format-muted = "";
            max-volume = 100;
            # exec = " wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3=="MUTED")print "Muted"; else print int($2 * 100) "%"}' "; nedded if module is cutom
            on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pwvucontrol";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            tooltip = true;
            tooltip-format = "{icon} at {volume}%";
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            max-volume = 100;
            format-source = "";
            format-source-muted = "";
            #exec = "wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{if ($3=="MUTED") print ""; else print "" int($2 * 100) "%"}' "; not needed only for custom module
            on-click = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
            on-click-right = "pwvucontrol";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%-";
            tooltip = true;
            # tooltip-format = " at {volume}%";
          };

          backlight = {
            interval = 10;
            device = "intel_backlight";
            format = "{icon}";
            tooltip = true;
            tooltip-format = "{icon} {percent}%";
            format-icons = [
              "󰃚"
              "󰃛"
              "󰃜"
              "󰃞"
              "󰃟"
              "󰃠"
            ];
            on-scroll-up = "brightnessctl set 2%+";
            on-scroll-down = "brightnessctl set 2%-";
            min-brightness = 5;
          };

          tray = {
            icon-size = 16;
            spacing = 10;
          };
        };
      };
    };

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
          "NIXOS_OZONE_WL,1"
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

        master = { };

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
          "$mainMod SHIFT, M, exit"
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
