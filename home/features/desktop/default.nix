{pkgs,...}: {
imports = [
./wayland.nix
./hyprland.nix
./fonts.nix
./waybar.nix
./hyprlock.nix
./wlogout.nix
];

home.packages = with pkgs; [];

}
