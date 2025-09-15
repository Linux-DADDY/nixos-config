{
  config,
  pkgs,
  ...
}: {
  # Enable systemd-boot as the bootloader
  boot.loader = {
    systemd-boot.enable = true; # Enables systemd-boot
    efi = {
      canTouchEfiVariables = true; # Allows NixOS to manage EFI variables (required for installation)
      #      efiSysMountPoint = "/boot"; # Mount point for the EFI partition (change if yours is different, e.g., "/boot/efi")
    };

    # Optional: Explicitly disable GRUB if it was previously enabled
    grub.enable = false;

    # Optional: Limit the number of boot generations (to save space)
    systemd-boot.configurationLimit = 10; # Keeps only the last 10 generations
  };
}
