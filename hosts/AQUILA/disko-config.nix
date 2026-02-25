{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "cry";
                # disable settings.keyFile if you want to use interactive password entry
                #passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                  keyFile = "/tmp/secret.key";
                };
                additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {

                    "@" = {
                      mountpoint = "/";
                      mountOptions = [
                        "space_cache=v2"
                        "compress=zstd"
                        "ssd"
                        "discard=async"
                        "noatime"
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
                      ];
                    };

                    "@swap" = {
                      mountpoint = "/.swapvol";
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
}
