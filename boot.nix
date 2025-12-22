{ config, pkgs, ... }:

{
  ########################################
  # BOOTLOADER
  ########################################
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "2"; # max EFI resolution (OK dla Legion Go)
      };
      efi.canTouchEfiVariables = true;
    };

    ########################################
    # KERNEL & MODULES
    ########################################
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "kvm-amd" ];

    # Najnowszy kernel – najlepsze wsparcie handhelda
    kernelPackages = pkgs.linuxPackages_latest;

    ########################################
    # KERNEL PARAMETERS
    ########################################
    kernelParams = [
      # AMD GPU
      "amdgpu.dcdebugmask=0x10"
      "amdgpu.ppfeaturemask=0xffffffff"

      # Rotacja konsoli (TTY / boot)
      # 0 = none, 1 = 90° right, 2 = 180°, 3 = 90° left
      "fbcon=rotate:3"

      # Quiet boot
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
    ];
  };

  ########################################
  # CONSOLE (TTY FONT + KEYMAP)
  ########################################
  console = {
  font = "latarcyrheb-sun32";
  keyMap = "pl";
  };

  ########################################
  # ZRAM SWAP (IDEALNE DLA HANDHELDA)
  ########################################
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50; # ~50% RAM jako zram
  };

  ########################################
  # POWER MANAGEMENT
  ########################################
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil"; # balans wydajność / bateria
  };

  ########################################
  # FIRMWARE
  ########################################
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}

