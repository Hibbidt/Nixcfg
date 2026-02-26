{
  disko.devices = {
    disk = {
      vda = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name = "ESP";
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "defaults" ];
              };
            };

            luks = {
              size = "100%";
              label = "luks";
              content = {
                type = "luks";
                name = "cry";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];

                content = {
                  type = "btrfs";
                  extraArgs = [ "-L" "nixos" "-f" ];
                  subvolumes = {

                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
                        "subvol=@"
                      ];
                    };

                    "@home" = {
                      mountpoint = "/home";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
                        "subvol=@home"

                      ];
                    };

                    "@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
                        "subvol=@nix"
                      ];
                    };

                    "@log" = {
                      mountpoint = "/var/log";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
                        "subvol=@log"
                      ];
                    };

                    "@persist" = {
                      mountpoint = "/persist";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
                        "subvol=persist"
                      ];
                    };

                    "@swap" = {
                      mountpoint = "/swap";
                      mountOptions = [
                        "noatime"
                        "subvol=@swap"
                      ];
                      swap.swapfile.size = "4G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
}
