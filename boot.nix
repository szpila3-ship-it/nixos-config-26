{ config, pkgs, ... }:

{
  # Bootloader - konfiguracja dla Legion Go
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "2";
      };
      efi.canTouchEfiVariables = true;
    };
    
    # AMD GPU i moduły dla Legion Go
    initrd.kernelModules = ["amdgpu"];
    kernelModules = ["kvm-amd"];
    
    # Najnowszy kernel dla najlepszego wsparcia handhelda
    kernelPackages = pkgs.linuxPackages_latest;
    
    kernelParams = [
      # AMD GPU
      "amdgpu.dcdebugmask=0x10"
      
      # Rotacja konsoli (dopasuj do orientacji ekranu)
      "fbcon=rotate:3"
      
      # Optymalizacje boot dla handheld
      "quiet"           # Mniej logów
      "splash"          # Splash screen
      "loglevel=3"      # Reduced verbosity
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      
      # AMD GPU Performance
      "amdgpu.ppfeaturemask=0xffffffff"  # Wszystkie funkcje GPU
      
      # Battery life (opcjonalne - możesz zakomentować dla lepszej wydajności)
      # "amdgpu.dpm=1"                   # Dynamic Power Management
    ];
  };

  # Zram swap - ŚWIETNE dla handhelda z ograniczoną pamięcią
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # 50% RAM jako zram
  };

  # Zarządzanie energią dla handhelda
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";  # Balans wydajności i oszczędzania
    
    # Opcjonalnie - powerpolicy dla lepszego battery life
    # cpuFreqGovernor = "powersave";
  };
  
  # Firmware dla AMD
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
}
