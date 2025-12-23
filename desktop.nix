{ config, pkgs, ... }:

{
  # KDE Plasma 6 - zoptymalizowane dla handhelda
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;  # Wayland dla lepszej wydajności i battery
  };
  
  services.desktopManager.plasma6.enable = true;

  # Włącz X11 (potrzebne dla niektórych gier i narzędzi)
  services.xserver = {
    enable = true;
    
    xkb = {
      layout = "pl";
      variant = "";
    };
  };
  # Ustawienie dla fastfetch
{
  services.xserver.desktopManager.plasma6.extraSessionCommands = ''
    ${pkgs.fastfetch}/bin/fastfetch &
  '';
}

  # Session management - zapisywanie stanu sesji
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file ksmserverrc --group General --key loginMode restoreSavedSession
  '';

  # Libinput - ekran dotykowy i touchpad
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = false;
    mouse.naturalScrolling = false;
    
    # Konfiguracja dla ekranu dotykowego
    touchpad = {
      tapping = true;
      disableWhileTyping = true;
      middleEmulation = true;
      scrollMethod = "twofinger";
    };
  };

  # Dźwięk - PipeWire (najlepsze dla handhelda / gamingu)

security.rtkit.enable = true;

services.pipewire = {
  enable = true;

  alsa.enable = true;
  alsa.support32Bit = true;   # Gry 32-bit (Steam/Proton)

  pulse.enable = true;        # Emulacja PulseAudio (WYMAGANE)
  jack.enable = true;         # Opcjonalne (pro audio)

  wireplumber.enable = true;  # Session manager (niska latencja)
};


  # ═══════════════════════════════════════════════════════════
  # OPTYMALIZACJE DLA LEGION GO (małego ekranu 8.8")
  # ═══════════════════════════════════════════════════════════
  
  # Zmienne środowiskowe dla lepszego skalowania
  environment.sessionVariables = {
    # Skalowanie dla małego ekranu
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    GDK_SCALE = "1.5";  # Dostosuj jeśli tekst jest za mały/duży
    GDK_DPI_SCALE = "1";
    
    # Wayland
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
  };
}


