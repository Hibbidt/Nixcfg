{
  pkgs,
  config,
  lib,
  ...
}: {
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = lib.mkForce false;
    settings = {
      General = {
        Experimental = true; # Shows batter charge of connected deivces if supported
      };
    };
  };
}
