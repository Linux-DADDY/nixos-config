let
  # Replace with your actual public keys
  user = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtCetonv6nPvA+GWC7+/az3Kpxe/P3qOWMP5pJY2Rx/"; # from ~/.ssh/id_ed25519.pub
  system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGuI18DfroMPpACePQ/8Y9+838RvbB0brqlBTqHlaIkr"; # from /etc/ssh/ssh_host_ed25519_key.pub
in {
  "user-password.age".publicKeys = [user system];
}
