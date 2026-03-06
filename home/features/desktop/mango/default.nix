{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./mango.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [];
}
