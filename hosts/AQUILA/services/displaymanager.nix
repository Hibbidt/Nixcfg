{
  config,
  lib,
  pkgs,
  ...
}: {
  services.displayManager.ly = {
    x11Support = true;
    enable = true;
  };
}
