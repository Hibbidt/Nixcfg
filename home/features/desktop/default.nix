{pkgs,...}: {
imports = [
./wayland.nix
./hyprland.nix
./fonts.nix
./waybar.nix
./hyprlock.nix
./wlogout.nix
./keepassxc.nix
./joplin.nix
./anki.nix
./rofi.nix
./flameshot.nix
./firefox.nix
./office.nix
];

home.packages = with pkgs; [];

}
