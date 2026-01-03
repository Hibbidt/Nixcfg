{ config, ... }: 
{ imports = [ 
./home.nix
../features/cli
../features/desktop
./dotfiles
../common
]; 

features= {
cli= {
bat.enable = true;
starship.enable = true;
eza.enable = true;
fish.enable = true;
fzf.enable = true;
nixvim.enable = true;
fastfetch.enable = true;
zoxide.enable = true;
nix-search-tv.enable = true;
};

desktop = {
wayland.enable = true;
hyprland.enable = true;
waybar.enable = true;
fonts.enable = true;
hyprlock.enable = true;
wlogout.enable = true;
keepassxc.enable = true;
joplin.enable = true;
anki.enable = true;
office.enable = true;
rofi.enable = true;
flameshot.enable = true;
firefox.enable = true;
};
};
}
