{
  pkgs,
  username,
  ...
}: {
  # Add this - it's the NixOS module specifically for virt-manager
  programs.virt-manager.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    #allowedBridges = ["br0"];
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [pkgs.OVMFFull.fd];
      };
    };
  };

  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };

  # Add "kvm" group as well
  users.users.${username}.extraGroups = ["libvirtd" "kvm"];

  # Since you're using programs.virt-manager.enable, you don't need
  # virt-manager in systemPackages
  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
  ];

  # AMD-specific virtualization settings
  boot.kernelModules = ["kvm-amd"];
  boot.extraModprobeConfig = ''
    options kvm_amd nested=1
  '';
}
