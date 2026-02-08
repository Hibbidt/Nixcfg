{pkgs, ...}: {

  imports = [
      ./hyprland.nix
      ./hyprlock.nix
      ./waybar.nix
      ./wayland.nix
      ./wlogout.nix
      ];

  home.packages = with pkgs; [];
}
