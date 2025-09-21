# declarative.nix
{
  # User and system info
  system = "x86_64-linux";
  username = "Linux-DADDY";
  hostname = "nixos";

  # Disk configuration
  diskoPath = "/dev/nvme0n1";
  persistPath = "/persist";
  timeZone = "Asia/Dhaka";
}
