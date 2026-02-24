{pkgs, ...}: {
  imports = [
    ./anki.nix
    ./firefox.nix
    ./flameshot.nix
    ./fonts.nix
    ./joplin.nix
    ./keepassxc.nix
    ./office.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    syncthing
    xournalpp
    qalculate-gtk
    kdePackages.okular
    kdePackages.dolphin
  ];
}
