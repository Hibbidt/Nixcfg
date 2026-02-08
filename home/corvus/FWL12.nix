{ config, ... }:
{
  imports = [
    ./home.nix
    ./dotfiles
    ../common
    ../features/cli
    ../features/desktop
    ../features/desktop/hyprland
    ../features/desktop/mango
  ];

  features = {

    cli = {
      bat.enable = true;
      starship.enable = true;
      eza.enable = true;
      fish.enable = true;
      fzf.enable = true;
      nvf.enable = true;
      fastfetch.enable = true;
      zoxide.enable = true;
      nix-search-tv.enable = true;
      nh.enable = true;
    };

    desktop = {

      fonts.enable = true;
      keepassxc.enable = true;
      joplin.enable = true;
      anki.enable = true;
      office.enable = true;
      flameshot.enable = true;
      firefox.enable = true;
      rofi.enable = true;

      mango = {
        mango.enable = true;
        wayland.enable = true;
      };

      hyprland = {
        wayland.enable = true;
        hyprland.enable = true;
        waybar.enable = true;
        hyprlock.enable = true;
        wlogout.enable = true;
      };
    };
  };
}
