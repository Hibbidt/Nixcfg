{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./btop.nix
    ./eza.nix
    ./fastfetch.nix
    ./fish.nix
    ./fzf.nix
    ./ghostty.nix
    ./mpv.nix
    ./nh.nix
    ./nix-search-tv.nix
    ./nix-output-monitor.nix
    ./nvf.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    coreutils
    curl
    fd
    procs
    ripgrep
    wget
  ];
}
