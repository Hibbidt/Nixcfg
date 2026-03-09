{
  config,
  lib,
  ...
}:
with lib; let
  mango = config.features.desktop.WM.mango;
in {
  imports = [
    ../common
    ./dotfiles
    ../features/cli
    ../features/desktop
    ../features/desktop/WM
    ./home.nix
  ];

  config = mkMerge [
    # (mkIf mango.enable {
    #   wayland.windowManager.mango = {
    #     settings = ''
    #       env=WLR_NO_HARDWARE_CURSORS,1
    #     '';
    #   };
    # })
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
          tealdeer.enable = true;
          zoxide.enable = true;
        };

        desktop = {
          anki.enable = false;
          firefox.enable = true;
          flameshot.enable = false;
          fonts.enable = true;
          joplin.enable = false;
          keepassxc.enable = true;
          office.enable = true;
          rofi.enable = true;

          mango = {
            mango.enable = true;
            wayland.enable = true;
            waybar.enable = true;
          };

          hyprland = {
            hyprland.enable = false;
            hyprlock.enable = false;
            waybar.enable = false;
            wayland.enable = false;
            wlogout.enable = false;
          };
        };
      };
    }
  ];
}
