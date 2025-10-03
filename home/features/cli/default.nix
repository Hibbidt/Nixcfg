{pkgs, ...}: {

imports = [
./fish.nix
./fzf.nix
./fastfetch.nix
];

programs.zoxide = {
enable = true;
options = ["--cmd cd"];
enableFishIntegration = true;
};

programs.eza = {
enable = true;
enableFishIntegration = true;
enableBashIntegration = true;
};

programs.bat = {enable = true;};


home.packages = with pkgs; [

coreutils
fd
btop
procs
ripgrep
tldr
];
}
