{
  config,
  lib,
  ...
}:
with lib;
let
  mango = config.features.desktop.WM.mango;
  hyprland = config.features.desktop.WM.hyprland;
in
{
  imports = [
    ../common
    ./dotfiles
    ../features/cli
    ../features/coding
    ../features/desktop
    ../features/desktop/WM
    ./home.nix
  ];

  config = mkMerge [
    (mkIf hyprland.enable {
      wayland.windowManager.hyprland = {
        settings = {
          monitor = [
            "eDP-1, 1920x1200@60, 0x0,1"
            ", preferred, auto, 1"
          ];

          input = {
            touchpad = {
              natural_scroll = true;
            };

            tablet = {
              output = "eDP-1";
            };
          };

          misc = {
            vfr = true;
            vrr = 1;
          };
        };
      };
      programs.waybar = {
        settings = {
          mainBar = {

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
              "tray"
              "pulseaudio"
              "pulseaudio#microphone"
              "backlight"
              "bluetooth"
              "cpu"
              "memory"
              "temperature"
              "network"
              "battery"
            ];

          };

        };
      };
    })

    (mkIf mango.enable {
      wayland.windowManager.mango = {
        autostart_sh = ''
          waybar -c ~/.config/waybar/config -s ~/.config/waybar/style.css &
        '';

      };
    })
    {
      features = {
        cli = {
          bat.enable = true;
          btop.enable = true;
          eza.enable = true;
          fastfetch.enable = true;
          fish.enable = true;
          fzf.enable = true;
          ghostty.enable = true;
          mpv.enable = true;
          nh.enable = true;
          nix-search-tv.enable = true;
          nix-output-monitor.enable = false;
          nvf.enable = true;
          starship.enable = true;
          tealdeer.enable = true;
          tmux.enable = true;
          zoxide.enable = true;
        };

        coding = {
          cpp.enable = true;
          python.enable = true;
          typst.enable = true;
          qml.enable = true;
        };

        desktop = {
          anki.enable = true;
          firefox.enable = true;
          flameshot.enable = true;
          fonts.enable = true;
          joplin.enable = true;
          keepassxc.enable = true;
          office.enable = true;
          rofi.enable = true;

          WM = {
            mango.enable = true;
            waybar.enable = false;
            hyprland.enable = true;
            hyprlock.enable = true;
            wlogout.enable = true;
          };
        };
      };
    }
  ];
}
