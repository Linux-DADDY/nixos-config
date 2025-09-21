{
  pkgs,
  lib,
  declarative,
  ...
}: let
  # Use persistPath from declarative configuration
  persistPath = declarative.persistPath;
in {
  # Enable FUSE for impermanence
  programs.fuse.userAllowOther = true;

  # Add user to 'fuse' group
  users.users.${declarative.username}.extraGroups = lib.mkAfter ["fuse"];

  boot.initrd = {
    # Ensure Btrfs support
    supportedFilesystems = ["btrfs"];

    # Include necessary kernel modules
    kernelModules = ["btrfs" "dm-mod" "dm-crypt"];

    # Add btrfs-progs to initrd
    extraUtilsCommands = ''
      copy_bin_and_libs ${pkgs.btrfs-progs}/bin/btrfs
    '';
  };

  # System persistence configuration
  environment.persistence.${persistPath} = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      {
        directory = "/etc/ssh";
        mode = "0755";
      }
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${persistPath} 0755 root root -"
    "d ${persistPath}/home 0755 root root -"
    "d ${persistPath}/home/${declarative.username} 0700 ${declarative.username} users -"
  ];

  fileSystems.${persistPath}.neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  security.sudo.extraConfig = "Defaults lecture = never";
}
