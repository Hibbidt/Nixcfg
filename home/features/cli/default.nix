{pkgs, ...}: {

  imports = [
      ./fish.nix
      ./nixvim.nix
      ./fastfetch.nix
      ./fzf.nix
      ./eza.nix
      ./bat.nix
      ./zoxide.nix
      ./starship.nix
      ./nix-search-tv.nix
      ./btop.nix
  ];


  home.packages = with pkgs; [
    coreutils
      fd
      btop
      procs
      nixvim
      ripgrep
      tldr
  ];
             }
