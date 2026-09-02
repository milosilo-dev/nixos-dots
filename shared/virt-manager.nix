{ config, pkgs, ... }:

{
  # Enable the libvirt daemon for QEMU/KVM virtualization
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  # Enable the virt-manager GUI application
  programs.virt-manager.enable = true;

  # Add your user to the libvirtd group to manage VMs
  users.users.miles.extraGroups = [ "libvirtd" ];
}   