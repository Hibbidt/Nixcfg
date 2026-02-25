{
  pkgs,
  config,
  lib,
  ...
}: {
  # btrfs autoscrub
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };
}
