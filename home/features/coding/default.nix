{pkgs, ...}: {
  imports = [
    ./cpp.nix
    ./qml.nix
    ./python.nix
  ];

  home.packages = with pkgs; [
  ];
}
