{config,lib,pkgs,...}:
{

 # stdenv.hostPlatform.system.autoUpgrade = {
 #   enable = true;
 #   operation = "boot";
 #   flags = [
 #   " --recreate-lock-fies"
 #   "--commit-lock-file"
 #   ];

# Added for Driver and Firmware updates
  services.fwupd = {
    enable = true;
    extraRemotes = ["lvfs-testing"];
# May be necessary to make the update succed once
    uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
  };

# Added for swaylock to work

  security.pam.services.hyprlock = {};


# btrfs autoscrub
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/"];
  };
}
