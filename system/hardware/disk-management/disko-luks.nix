{
  inputs,
  diskDevice,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = {
    disk = {
      nvme0n1 = {
        type = "disk";
        device = diskDevice; # Uses declarative.diskoPath
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              label = "boot";
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            luks = {
              size = "100%";
              label = "luks";
              content = {
                type = "luks";
                name = "cryptroot";
                extraOpenArgs = [
                  "--allow-discards"
                  "--perf-no_read_workqueue"
                  "--perf-no_write_workqueue"
                ];
                content = {
                  type = "btrfs";
                  extraArgs = ["-L" "nixos" "-f"];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                      mountOptions = ["subvol=root" "compress=zstd:1" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120"];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = ["subvol=home" "compress=zstd:1" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120" "autodefrag"];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = ["subvol=nix" "compress=zstd:1" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120" "nodatacow" "nodatasum"];
                    };
                    "/persist" = {
                      mountpoint = "/persist";
                      mountOptions = ["subvol=persist" "compress=zstd:1" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120"];
                    };
                    "/log" = {
                      mountpoint = "/var/log";
                      mountOptions = ["subvol=log" "compress=zstd:1" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120" "nodatacow" "nodatasum"];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
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
