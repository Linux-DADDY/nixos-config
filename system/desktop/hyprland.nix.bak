{
  pkgs,
  inputs,
  ...
}: {
  # Enable Hyprland with XWayland support.
  # This sets up the compositor without configuring internal settings like binds or rules.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
    #  package = inputs.hyprland.packages.${pkgs.system}.hyprland; # Use the version from flake inputs for better compatibility and updates
  };

  # Configure XDG Desktop Portal for screen sharing, file dialogs, etc.
  # Prioritizes Hyprland's portal with fallbacks.
  xdg.portal = {
    enable = true;
    wlr.enable = true; # Enables Wayland backend support
    xdgOpenUsePortal = true; # Routes xdg-open through the portal
    config.common.default = ["hyprland" "gtk"]; # Set Hyprland as primary, GTK as fallback
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland # Primary portal for Hyprland
      xdg-desktop-portal-gtk # Fallback for GTK-based apps
      xdg-desktop-portal-wlr # Additional Wayland support (optional but useful for compatibility)
    ];
  };

  # PAM configuration for lock screens (swaylock and hyprlock).
  # This allows authentication without additional tweaks.
  security.pam.services = {
    swaylock.text = ''
      auth include login
    '';
    hyprlock = {}; # Empty attrset enables default PAM for hyprlock
  };

  # Enable dconf for GTK+ theme and settings management.
  programs.dconf.enable = true;

  # Security services: GNOME Keyring for secret storage and GnuPG agent.
  services.gnome.gnome-keyring.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true; # Uncommented for better SSH key management (common in desktop setups)
  };

  # Enable DBus (required for many desktop services) and accounts-daemon for user session management.
  services = {
    dbus.enable = true;
    accounts-daemon.enable = true;
  };

  # Optional: Enable Polkit for privilege escalation (useful for graphical apps needing admin rights).
  security.polkit.enable = true;

  # Optional: Set environment variables for better Wayland compatibility.
  # These help apps like Electron/Chromium detect Wayland.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Enables Ozone Wayland support for Chromium-based apps
    XDG_SESSION_TYPE = "wayland"; # Default to Wayland session
  };
}
