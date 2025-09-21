{
  config,
  pkgs,
  ...
}: {
  # ... your existing configuration above ...

  # Enable XFS filesystem support
  boot.supportedFilesystems = ["xfs"];

  # Auto-mount XFS drives at boot
  fileSystems."/media/Backup_DV" = {
    device = "/dev/disk/by-uuid/f27d67cb-dd10-4a79-9c12-4ea8c3014fbc";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  fileSystems."/media/Personal_DV" = {
    device = "/dev/disk/by-uuid/8860bdeb-8a6b-4318-ae00-a0de5cb8e8f7";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  fileSystems."/media/Placeholder" = {
    device = "/dev/disk/by-uuid/ff8e0bcf-4532-4a36-86fd-74e8a5bc0e3f";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  fileSystems."/media/Virtual_Boot" = {
    device = "/dev/disk/by-uuid/5387acba-a910-4666-8bc8-2a9eda9294d1";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  fileSystems."/media/Black_Box" = {
    device = "/dev/disk/by-uuid/f4cc921a-9a25-4a00-8238-bfc55ea204a3";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  fileSystems."/media/Vault_Zero" = {
    device = "/dev/disk/by-uuid/2c00732a-7392-487c-913a-808f0aea9e3f";
    fsType = "xfs";
    options = [
      "defaults"
      "noatime"
      "nodiratime"
      "nofail"
      "x-gvfs-show"
      "allocsize=64m"
    ];
  };

  # Set ownership for Linux-DADDY after mounting
  systemd.services.set-media-permissions = {
    description = "Set ownership for media drives for Linux-DADDY";
    after = [
      "multi-user.target"
      "media-Backup_DV.mount"
      "media-Personal_DV.mount"
      "media-Placeholder.mount"
      "media-Virtual_Boot.mount"
      "media-Black_Box.mount"
      "media-Vault_Zero.mount"
    ];
    requires = [
      "media-Backup_DV.mount"
      "media-Personal_DV.mount"
      "media-Placeholder.mount"
      "media-Virtual_Boot.mount"
      "media-Black_Box.mount"
      "media-Vault_Zero.mount"
    ];
    wantedBy = ["multi-user.target"];
    script = ''
      # Get the actual UID and GID for Linux-DADDY
      USER_ID=$(${pkgs.coreutils}/bin/id -u Linux-DADDY 2>/dev/null || echo "1001")
      GROUP_ID=$(${pkgs.coreutils}/bin/id -g Linux-DADDY 2>/dev/null || echo "100")

      echo "Setting ownership to Linux-DADDY (UID: $USER_ID, GID: $GROUP_ID)"

      # Set ownership for all mounted drives using the actual user ID
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Backup_DV
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Personal_DV
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Placeholder
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Virtual_Boot
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Black_Box
      ${pkgs.coreutils}/bin/chown -R $USER_ID:$GROUP_ID /media/Vault_Zero

      # Set permissions to allow full access
      ${pkgs.coreutils}/bin/chmod 755 /media/Backup_DV
      ${pkgs.coreutils}/bin/chmod 755 /media/Personal_DV
      ${pkgs.coreutils}/bin/chmod 755 /media/Placeholder
      ${pkgs.coreutils}/bin/chmod 755 /media/Virtual_Boot
      ${pkgs.coreutils}/bin/chmod 755 /media/Black_Box
      ${pkgs.coreutils}/bin/chmod 755 /media/Vault_Zero
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
    };
  };
}
