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
fish.enable = true;
fzf.enable = true;
fastfetch.enable = true;
};

desktop = {
wayland.enable = true;
hyprland.enable = true;
fonts.enable = true;
};
};



}
