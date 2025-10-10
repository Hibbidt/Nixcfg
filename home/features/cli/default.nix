{pkgs, ...}: {

imports = [
./fish.nix
./fzf.nix
./fastfetch.nix
./fzf.nix
./eza.nix
./bat.nix
./zoxide.nix
];


home.packages = with pkgs; [
coreutils
fd
btop
procs
ripgrep
tldr
];
}
