{ config, pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # 32-bit OpenGL/Vulkan for Steam
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;  # RTX 5070 needs open driver
    nvidiaSettings = true;
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
