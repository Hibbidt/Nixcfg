{ pkgs, ... }:
{

  imports = [
    ./fish.nix
    ./nvf.nix
    ./fastfetch.nix
    ./fzf.nix
    ./eza.nix
    ./bat.nix
    ./zoxide.nix
    ./starship.nix
    ./nix-search-tv.nix
    ./nh.nix
    ./btop.nix
  ];

  home.packages = with pkgs; [
    coreutils
    fd
    btop
    procs
    ripgrep
    tealdeer
  ];
}
