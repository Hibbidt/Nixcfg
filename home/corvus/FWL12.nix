{
  config,
  lib,
  ...
}:
with lib; let
  hypr = config.features.desktop.hyprland.hyprland;
in {
  imports = [
    ../common
    ./dotfiles
    ../features/cli
    ../features/desktop
    ../features/desktop/hyprland
    ../features/desktop/mango
    ./home.nix
  ];

  config = mkMerge [
    (mkIf hypr.enable {
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
    })

    {
      features = {
        cli = {
          bat.enable = true;
          eza.enable = true;
          fastfetch.enable = true;
          fish.enable = true;
          fzf.enable = true;
          ghostty.enable = true;
          mpv.enable = true;
          nh.enable = true;
          nix-search-tv.enable = true;
          nvf.enable = true;
          starship.enable = true;
          zoxide.enable = true;
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

          mango = {
            mango.enable = true;
            wayland.enable = true;
          };

          hyprland = {
            hyprland.enable = true;
            hyprlock.enable = true;
            waybar.enable = true;
            wayland.enable = true;
            wlogout.enable = true;
          };
        };
      };
    }
  ];
}
