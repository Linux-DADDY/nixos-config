{
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = [
    "amd_pstate=guided" # Better power management for Zen 2+
    "amdgpu"
    "iommu=pt" # Improves performance with IOMMU
  ];

  hardware.amdgpu = {
    amdvlk = {
      enable = false; # Prefer RADV over AMDVLK
      support32Bit.enable = false;
    };
    opencl = {
      enable = true; # Enable OpenCL support
    };
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Video acceleration
      vaapiVdpau
      libvdpau-va-gl

      # Mesa drivers
      mesa

      # Vulkan
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools

      # Additional AMD tools (optional but useful)
      rocmPackages.clr.icd # Better OpenCL support
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];
  };

  environment.variables = {
    # Video acceleration
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";

    # Prefer RADV (Mesa) Vulkan driver
    AMD_VULKAN_ICD = "RADV";

    # Let the Vulkan loader auto-detect ICDs from the directory
    # This handles both 32-bit and 64-bit automatically
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/";

    # Optional: Force high performance mode (uncomment if needed)
    # AMD_VULKAN_PERFORMANCE_MODE = "high";
  };

  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "modesetting"];

  # AMD-specific power management (optional but recommended)
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
