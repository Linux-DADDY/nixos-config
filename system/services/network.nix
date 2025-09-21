{
  config,
  pkgs,
  ...
}: {
  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Optional: Disable the default NixOS wireless support (to avoid conflicts with NetworkManager)
  # If you need WiFi, NetworkManager will handle it instead.
  networking.wireless.enable = false;

  # Optional: Ensure NetworkManager waits for the network to be online before booting services
  # This is useful for systems that need internet during boot (e.g., for remote unlocks).
  systemd.services.NetworkManager-wait-online.enable = false; # Set to true if you need it

  # Optional: Install useful NetworkManager tools
  # - nm-applet: System tray icon for GNOME/KDE/etc.
  # - networkmanager-openvpn: For VPN support (add more plugins as needed)
  environment.systemPackages = with pkgs; [
    networkmanagerapplet # GUI applet
  ];

  # Optional: Configure DNS resolution (e.g., use systemd-resolved with NetworkManager)
  # This integrates NetworkManager with resolved for better DNS handling.
  networking.networkmanager.dns = "systemd-resolved";
  services.resolved.enable = true;

  # Optional: If you use a desktop environment, enable the NetworkManager applet automatically
  # Example for GNOME (adjust for KDE, XFCE, etc.)
  programs.nm-applet.enable = true; # Uncomment if using a DE that supports it
}
