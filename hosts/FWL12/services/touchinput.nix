{
  pkgs,
  config,
  lib,
  ...
}: {
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
  };
}
