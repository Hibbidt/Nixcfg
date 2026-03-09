{pkgs, ...}: {
  imports = [
    ./hyprland.nix
    ./hyprlock.nix
    ./mango.nix
    ./quickshell.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
  ];
}

