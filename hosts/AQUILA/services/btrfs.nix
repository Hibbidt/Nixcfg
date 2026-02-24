{
  pkgs,
  config,
  lib,
  ...
}: {
  # Added for Driver and Firmware updates
  services.fwupd = {
    enable = true;
    extraRemotes = ["lvfs-testing"];
    # May be necessary to make the update succed once
    uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
  };

  # btrfs autoscrub
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };
}
