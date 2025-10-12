{pkgs,...}: {
imports = [
./wayland.nix
./hyprland.nix
./fonts.nix
./waybar.nix
./hyprlock.nix
./wlogout.nix
./keepassxc.nix
];

home.packages = with pkgs; [];

}
