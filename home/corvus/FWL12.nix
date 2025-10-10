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
eza.enable = true;
fish.enable = true;
fzf.enable = true;
fastfetch.enable = true;
zoxide.enable = true;
};

desktop = {
wayland.enable = true;
hyprland.enable = true;
waybar.enable = true;
fonts.enable = true;
};
};
}
