{
  config,
  lib,
  ...
}:
with lib;
let
  mango = config.features.desktop.WM.mango;
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
