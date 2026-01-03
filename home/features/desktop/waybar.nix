{config,lib,pkgs,...}: with lib;
let
cfg = config.features.desktop.waybar;
in {
  options.features.desktop.waybar.enable = mkEnableOption "Waybar options";

  config = mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      style =
        ''
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
#temperature,
#network,
#tray,
#temperature,
#hyprland-workspaces,
#idle_inhibitor,
#custom-lock_screen,
#custom-power_btn,
#custom-power_rofi,
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
      "custom/power_btn"
        "custom/lock_screen"
        "hyprland/workspaces"
    ];

    modules-center = [
      "idle_inhibitor"
        "clock"
        "custom/launch_rofi"
    ];

    modules-right = [
      "pulseaudio"
        "pulseaudio#microphone"
        "backlight"
        "bluetooth"
        "cpu"
        "memory"
        "temperature"
        "network"
        "tray"
        "battery"
    ];

    "custom/launch_rofi" = {
      format = " ";
      max-length = 10;
      on-click = "sh -c '(sleep 0.5s; pkill rofi || rofi -show combi -modes combi -combi-modes \"window,drun\" -show-icons -theme fullscreen-preview)' & disown";
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


    "custom/power_btn" = {
      format = "";
      on-click = "sh -c '(sleep 0.5s; wlogout --protocol layer-shell)' & disown";
      tooltip = false;
    };

    "custom/lock_screen" = {
      format = "";
      on-click = "sh -c '(sleep 0.5s; hyprlock)' & disown";
      tooltip = false;
    };

    "hyprland/workspaces" = {
      format = "{name} {icon}";
      on-click = "activate";
      on-scroll-up =   "hyprctl dispatch workspace e+1";
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



    memory= {
      interval= 30;
      format = "";
      max-length = 10;
      tooltip = true;
      tooltip-format= "Memory - {used:0.1f}GB used ({percentage}%)\nSwap - {swapUsed:0.1f}GB used {swapPercentage}%";
    };

    network = {
      format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
      format = "{icon}";
      format-wifi = "{icon}";
      format-ethernet = "󰀂";
      format-disconnected = "󰤮";
      tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
      tooltip-format-disconnected = "Disconnected";
      interval= 10;
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
      tooltip-format-enumerate-connected= "({device_alias})\t{device_address}";
      tooltip-format-enumerate-connected-battery = "({device_alias})\t({device_address})\t{device_battery_percentage}%";
    };

    clock = {
      format = "{:%R}";
      format-alt = "{:%A, %B %d, %Y (%T)}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode           = "year";
        mode-mon-col  = 3;
        weeks-pos     = "right";
        on-scroll     = 1;
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


    cpu = {
      interval = 10;
      format = "";
      max-length = 10;
      format-alt-click = "click-right";
      format-alt = " {usage}%";
      on-click = "kitty --start-as=fullscreen --title btop sh -c 'btop'";
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
      tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}% {cycles} ({health}%)\n {timeTo}";
      tooltip-format-charging =  "{power:>1.0f}W↑ {capacity}% {cycles} ({health}%)\n {timeTo}" ;
      interval = 10;
      states = {
        warning = 20;
        critical = 10;
      };
    };

    temperature = {
      format = "{icon}";
      format-icons = ["" "" "" "" ""];
      tooltip = true;
      tooltip-format = "{temperatureC}°C";
      format-alt-click = "click-right";
      format-alt = "{icon}{temperatureK}K";
    };


    pulseaudio = {
      format = "{icon}";
      format-muted = "";
      max-volume= 100;
# exec = " wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{if ($3=="MUTED")print "Muted"; else print int($2 * 100) "%"}' "; nedded if module is cutom
      on-click = "wpctl set-mute @DEFAULT_SINK@ toggle";
      on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
      on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
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
      on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%+";
      on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%-";
      tooltip = true;
      tooltip-format = " at {volume}%";
    };



    backlight = {
      interval = 10;
      device = "intel_backlight";
      format = "{icon}";
      tooltip = true;
      tooltip-format = "{icon} {percent}%";
      format-icons = [ "󰃚"  "󰃛" "󰃜" "󰃞" "󰃟" "󰃠" ];
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
};
}

