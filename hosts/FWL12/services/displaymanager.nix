{
  config,
  lib,
  pkgs,
  ...
}: {
  services.displayManager.ly = {
    x11Support = true;
    enable = true;

    settings = {
      clock = "%c";
      battery = "BAT1";
    };
  };
}
