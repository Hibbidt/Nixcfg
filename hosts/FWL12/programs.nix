{
  pkgs,
  config,
  lib,
  ...
}: {
  security.pam.services.hyprlock = {};

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    localsend.enable = true;

    fish.enable = true;
  };
}
