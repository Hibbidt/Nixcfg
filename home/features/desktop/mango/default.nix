{pkgs, ...}: {

  imports = [
  ./wayland.nix
  ./mango.nix
      ];

  home.packages = with pkgs; [];
}
