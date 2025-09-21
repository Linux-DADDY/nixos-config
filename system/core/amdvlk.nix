{
  pkgs,
  lib,
  ...
}: {
  boot.kernelParams = [
    "amd_pstate=guided" # Better power management for Zen 2+
    "iommu=pt" # Improves performance with IOMMU
  ];

  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    opencl.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # Video acceleration
      vaapiVdpau
      libvdpau-va-gl

      # Vulkan tools (for debugging/testing)
      vulkan-validation-layers
      vulkan-tools

      # OpenCL
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      # Only the essentials for 32-bit
      mesa
    ];
  };

  environment.variables = {
    # Video acceleration
    VDPAU_DRIVER = "radeonsi";
    LIBVA_DRIVER_NAME = "radeonsi";

    # Optional: Set default Vulkan driver
    # Remove this to let apps auto-select between RADV and AMDVLK
    # AMD_VULKAN_ICD = "RADV";
  };

  services.xserver.videoDrivers = lib.mkDefault ["amdgpu" "modesetting"];
  powerManagement.cpuFreqGovernor = lib.mkDefault "schedutil";
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
}
