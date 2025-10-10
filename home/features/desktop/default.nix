{pkgs,...}: {
imports = [
./wayland.nix
./hyprland.nix
./fonts.nix
./waybar.nix
];

home.packages = with pkgs; [];

}
