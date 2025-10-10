{config,lib,pkgs,...}: with lib;
let
cfg = config.features.desktop.waybar;
in {
options.features.desktop.waybar.enable = mkEnableOption "Waybar options";

config = mkIf cfg.enable {
programs.waybar = {
enable = true;
      style = ''
        @define-color background-darker rgba(30, 31, 41, 230);
        @define-color background #282a36;
        @define-color selection #44475a;
        @define-color foreground #f8f8f2;
        @define-color comment #6272a4;
        @define-color cyan #8be9fd;
        @define-color green #50fa7b;
        @define-color orange #ffb86c;
        @define-color pink #ff79c6;
        @define-color purple #bd93f9;
        @define-color red #ff5555;
        @define-color yellow #f1fa8c;

        * {
            border: none;
            border-radius: 0;
            font-family: Jetbrains Mono Nerd Font;
            font-weight: bold;
            font-size: 14px;
            min-height: 0;
        }

        window#waybar {
            background: rgba(21, 18, 27, 0);
            color: #cdd6f4;
        }

        tooltip {
            background: #1e1e2e;
            border-radius: 10px;
            border-width: 2px;
            border-style: solid;
            border-color: #11111b;
        }

        #workspaces button {
            padding: 5px;
            color: #313244;
            margin-right: 5px;
        }

        #workspaces button.active {
            color: #11111b;
            background: #a6e3a1;
            border-radius: 10px;
        }

        #workspaces button.focused {
            color: #a6adc8;
            background: #eba0ac;
            border-radius: 10px;
        }

        #workspaces button.urgent {
            color: #11111b;
            background: #a6e3a1;
            border-radius: 10px;
        }

        #workspaces button:hover {
            background: #11111b;
            color: #cdd6f4;
            border-radius: 10px;
        }

        #custom-language,
        #custom-updates,
        #custom-caffeine,
        #window,
        #clock
        #battery,
        #pulseaudio,
        #microphone,  
        #network,
        #workspaces,
        #tray,
        #backlight {
            background: #1e1e2e;
            padding: 0px 10px;
            margin: 3px 0px;
            margin-top: 10px;
            border: 1px solid #181825;
        }

        #tray {
            border-radius: 10px;
            margin-right: 10px;
        }

        #workspaces {
            background: #1e1e2e;
            border-radius: 10px;
            margin-left: 10px;
            padding-right: 0px;
            padding-left: 5px;
        }

        #custom-caffeine {
            color: #89dceb;
            border-radius: 10px 0px 0px 10px;
            border-right: 0px;
            margin-left: 10px;
        }

        #custom-language {
            color: #f38ba8;
            border-left: 0px;
            border-right: 0px;
        }

        #custom-updates {
            color: #f5c2e7;
            border-left: 0px;
            border-right: 0px;
        }

        #window {
            border-radius: 10px;
            margin-left: 60px;
            margin-right: 60px;
        }

        #clock {
            color: #fab387;
            border-radius: 10px 0px 0px 10px;
            margin-left: 0px;
            border-right: 0px;
        }
        #calendar {
            color: #fab387;
            border-radius: 10px 0px 0px 10px;
            margin-left: 0px;
            border-right: 0px;
        }

        #network {
            color: #f9e2af;
            border-left: 0px;
            border-right: 0px;
        }

        #pulseaudio {
            color: #89b4fa;
            border-left: 0px;
            border-right: 0px;
        }

        #pulseaudio.microphone {
            color: #cba6f7;
            border-left: 0px;
            border-right: 0px;
        }

        #battery {
            color: #a6e3a1;
            border-radius: 0 10px 10px 0;
            margin-right: 10px;
            border-left: 0px;
        }

        #custom-weather {
            border-radius: 0px 10px 10px 0px;
            border-right: 0px;
            margin-left: 0px;
        }
        #bluetooth {
            margin-right: 8px;
        }
      '';

      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          height = 0;
          modules-left = [
          "clock"
          "hyprland/workspaces"
          ];

          modules-center = ["hyprland/window"];
          modules-right = [
          "tray"
          "battery"
          "bluetooth"
          "network"
          ];

          "hyprland/window" = {
            format = "👉 {}";
            seperate-outputs = true;
          };

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            on-click = "activate";
            format = " {name} {icon} ";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
            format-icons = {
              "1" = "";
              "2" = "";
              "3" = "";
              "4" = "";
              "5" = "";
              "6" = "";
              "7" = "";
            };
            persistent_workspaces = {
              "1" = [];
              "2" = [];
              "3" = [];
              "4" = [];
            };
          };


    network = {
    # interface = "interface";
    format = "{ifname}";
    format-wifi = "{essid} ({signalStrength}%) ";
    format-ethernet = "{ipaddr}/{cidr} 󰊗";
    format-disconnected = ""; #An empty format will hide the module.
    tooltip-format= "{ifname} via {gwaddr} 󰊗";
    tooltip-format-wifi= "{essid} ({frequency} GHz)({signalStrength}%) ";
    tooltip-format-ethernet= "{ifname} ";
    tooltip-format-disconnected= "Disconnected";
    max-length= "50";
};


    battery = {
    format = "{capacity}% {icon}";
    format-discharging = "{icon}";
    format-charging = "{icon}";
    format-plugged = "";
    format-icons = {
    charging = ["󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"];
    default = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
    };
    format-full = "󰂅";
    tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
    tooltip-format-charging =  "{power:>1.0f}W↑ {capacity}%";
    interval = "5";
    states = {
    warning = "20";
    critical = "10";
    };
    };

    bluetooth = {
    format = "";
    format-disabled = "󰂲";
    format-connected = "";
    tooltip-format = "Devices connected: {num_connections}";
    on-click = "blueberry";
};

          pulseaudio = {
            format = "{icon} {volume}%";
            tooltip = false;
            format-muted = " Muted";
            on-click = "pamixer -t";
            on-scroll-up = "pamixer -i 5";
            on-scroll-down = "pamixer -d 5";
            scroll-step = "5";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
          };

            "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = " {volume}%";
            format-source-muted = " Muted";
            #on-click = "pamixer --default-source -t";
            #on-scroll-up = "pamixer --default-source -i 5";
            #on-scroll-down = "pamixer --default-source -d 5";
            scroll-step = 5;
          };


          tray = {
            icon-size = 13;
            spacing = 10;
          };

    clock = {
        format = " {:%R   %a. %d/%m}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
                    mode           = "year";
                    mode-mon-col  = "3";
                    weeks-pos     = "right";
                    on-scroll     = "1";
                    format = {
                              months =     "<span color='#ffead3'><b>{}</b></span>";
                              days =       "<span color='#ecc6d9'><b>{}</b></span>";
                              weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
                              weekdays=    "<span color='#ffcc66'><b>{}</b></span>";
                              today =    "<span color='#ff6699'><b><u>{}</u></b></span>";
                              };
                    };
        actions=  {
                    on-click-right= "mode";
                    on-scroll-up= "shift_up";
                    on-scroll-down= "shift_down";
                    };
    };

};
};
};
};
}
