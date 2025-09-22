{
  pkgs,
  lib,
  declarative,
  ...
}: let
  persistPath = declarative.persistPath;
in {
  programs.fuse.userAllowOther = true;
  users.users.${declarative.username}.extraGroups = ["fuse"];

  boot.initrd = {
    supportedFilesystems = ["btrfs"];
    kernelModules = ["btrfs" "dm-mod" "dm-crypt"];
    extraUtilsCommands = ''
      copy_bin_and_libs ${pkgs.btrfs-progs}/bin/btrfs
    '';
  };

  environment.persistence.${persistPath} = {
    enable = true;
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/bluetooth"
      "/var/lib/NetworkManager"
      {
        directory = "/etc/ssh";
        mode = "0755";
      }

      # ADD USER DIRECTORIES HERE
      "/home/${declarative.username}/Downloads"
      "/home/${declarative.username}/Pictures"
      "/home/${declarative.username}/Documents"
      "/home/${declarative.username}/Videos"
      "/home/${declarative.username}/Desktop"
      "/home/${declarative.username}/Public"
      "/home/${declarative.username}/Templates"
      "/home/${declarative.username}/.gnupg"
      "/home/${declarative.username}/.local/share/keyrings"
      "/home/${declarative.username}/.config/git"
      "/home/${declarative.username}/.zen"
      "/home/${declarative.username}/.cache/zen"
      "/home/${declarative.username}/.local/share/applications"
      "/home/${declarative.username}/.local/share/icons"
      "/home/${declarative.username}/.config/fontconfig"
      "/home/${declarative.username}/Games"
      "/home/${declarative.username}/Game-Mods"
      "/home/${declarative.username}/Appimages"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${persistPath} 0755 root root -"
    "d ${persistPath}/home 0755 root root -"
    "d ${persistPath}/home/${declarative.username} 0700 ${declarative.username} users -"

    # Create all subdirectories
    "d ${persistPath}/home/${declarative.username}/Downloads 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Pictures 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Documents 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Videos 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Desktop 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Public 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Templates 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.gnupg 0700 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/keyrings 0700 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.config/git 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.zen 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.cache/zen 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/applications 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.local/share/icons 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/.config/fontconfig 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Games 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Game-Mods 0755 ${declarative.username} users -"
    "d ${persistPath}/home/${declarative.username}/Appimages 0755 ${declarative.username} users -"
  ];

  fileSystems.${persistPath}.neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  security.sudo.extraConfig = "Defaults lecture = never";
}
