{ config, ... }: 
{ imports = [ 
./home.nix
../features/cli
../features/desktop
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
};
};



}
