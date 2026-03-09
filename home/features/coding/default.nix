{pkgs, ...}: {
  imports = [
    ./cpp.nix
    ./qml.nix
    ./python.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
  ];
}
