# Konfiguracja NixOS dla Lenovo Legion Go

![NixOS](https://img.shields.io/badge/NixOS-25.11-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Lenovo%20Legion%20Go-red.svg)
![Desktop](https://img.shields.io/badge/Desktop-KDE%20Plasma%206-blue.svg)
![Język](https://img.shields.io/badge/Język-Polski-red.svg)

Osobista konfiguracja NixOS zoptymalizowana pod **Lenovo Legion Go** - urządzenie do grania przenośne.

[**English version**](README.en.md) | **Wersja polska**

## 🎮 Sprzęt

- **Urządzenie**: Lenovo Legion Go
- **CPU**: AMD Ryzen Z1 Extreme
- **GPU**: AMD Radeon Graphics (RDNA 3)
- **RAM**: 16GB
- **Wyświetlacz**: 8.8" 2560x1600 @ 144Hz
- **Dysk**: NVMe SSD

## ✨ Funkcje

### Optymalizacje gamingowe
- ✅ **Handheld Daemon** - wsparcie kontrolerów Legion Go, kontrola TDP, zarządzanie wentylatorami
- ✅ **GameMode** - automatyczne optymalizacje wydajności dla gier
- ✅ **Gamescope** - compositor do gier (jak Steam Deck)
- ✅ **MangoHud** - nakładka FPS i monitoring wydajności
- ✅ **Vulkan (RADV)** - sterowniki AMD GPU z pełnym wsparciem Vulkan
- ✅ **Wsparcie 32-bit** - dla starszych gier

### Środowisko graficzne
- ✅ **KDE Plasma 6** na Waylandzie
- ✅ **Pipewire** - nowoczesny system audio o niskiej latencji
- ✅ **Ekran dotykowy** - pełna konfiguracja libinput
- ✅ **Skalowanie UI** - zoptymalizowane dla ekranu 8.8" o wysokiej rozdzielczości
- ✅ **Przywracanie sesji** - automatyczne zapisywanie sesji

### System
- ✅ **Najnowszy kernel** - najlepsze wsparcie dla handhelda
- ✅ **Optymalizacje AMD GPU** - pełny ppfeaturemask, zarządzanie energią
- ✅ **zramSwap** - kompresja 50% RAM dla lepszej wydajności
- ✅ **Zarządzanie energią** - governor schedutil, optymalizacja baterii
- ✅ **Bluetooth** - wsparcie kontrolerów i akcesoriów

### Lokalizacja polska
- ✅ **Język systemowy**: Polski
- ✅ **Układ klawiatury**: Polski
- ✅ **Strefa czasowa**: Europa/Warszawa
- ✅ **Słownik**: Hunspell Polski
- ✅ **Format daty/czasu**: Polski

### Narzędzia deweloperskie
- Google Chrome (natywny Wayland)
- Firefox
- Sublime Text 4
- Discord, Signal, Telegram
- Git, Vim, Nano
- I więcej...

## 📁 Struktura konfiguracji

```
/etc/nixos/
├── configuration.nix       # Główny plik konfiguracyjny
├── boot.nix               # Bootloader, kernel, ustawienia AMD GPU
├── desktop.nix            # KDE Plasma 6, Wayland, ustawienia wyświetlacza
├── gaming.nix             # GameMode, Gamescope, MangoHud
├── networking.nix         # Konfiguracja sieci
├── locale.nix             # Język i strefa czasowa (Polski)
├── users.nix              # Konta użytkowników
├── packages.nix           # Pakiety systemowe
├── services.nix           # Handheld daemon, Bluetooth, zarządzanie energią
├── sync.nix               # Skrypt synchronizacji z GitHub
├── home-manager.nix       # Konfiguracja użytkownika
└── hardware-configuration.nix  # Auto-generowana konfiguracja sprzętu
```

## 🚀 Instalacja

### Wymagania
- NixOS 25.11 zainstalowany na Legion Go
- Podstawowa znajomość NixOS
- Dostęp do terminala

### Szybki start

1. **Sklonuj repozytorium:**
```bash
git clone https://github.com/szpila3-ship-it/nixos-config.git ~/nixos-config
```

2. **Zrób backup obecnej konfiguracji:**
```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

3. **Skopiuj pliki konfiguracyjne:**
```bash
sudo cp ~/nixos-config/*.nix /etc/nixos/
```

4. **Wygeneruj swoją konfigurację sprzętu:**
```bash
sudo nixos-generate-config --show-hardware-config > /tmp/hardware.nix
sudo cp /tmp/hardware.nix /etc/nixos/hardware-configuration.nix
```

5. **Edytuj ustawienia użytkownika:**
```bash
sudo nano /etc/nixos/users.nix  # Ustaw swoją nazwę użytkownika/hasło
sudo nano /etc/nixos/home-manager.nix  # Ustaw swój email Git
```

6. **Przebuduj system:**
```bash
sudo nixos-rebuild switch
```

7. **Restart:**
```bash
reboot
```

**Szczegółowa instrukcja**: Zobacz [INSTALL.pl.md](INSTALL.pl.md)

## 🛠️ Dostosowywanie

### Zmiana skalowania UI
Jeśli tekst jest za mały/duży na ekranie 8.8", edytuj `desktop.nix`:

```nix
environment.sessionVariables = {
  GDK_SCALE = "1.5";  # Wypróbuj: 1.25, 1.5, 1.75, lub 2.0
};
```

### Dodawanie pakietów
Edytuj `packages.nix` i dodaj pakiety do `environment.systemPackages`:

```nix
environment.systemPackages = with pkgs; [
  # Twoje pakiety tutaj
  steam
  vscode
  # itp...
];
```

### Zmiana profilu energii
Edytuj `boot.nix`:

```nix
# Dla lepszej wydajności:
powerManagement.cpuFreqGovernor = "performance";

# Dla lepszej żywotności baterii:
powerManagement.cpuFreqGovernor = "powersave";

# Zbalansowane (domyślne):
powerManagement.cpuFreqGovernor = "schedutil";
```

## 📝 Przydatne komendy

### Zarządzanie systemem
```bash
nos              # Przebuduj system (alias dla sudo nixos-rebuild switch)
noc              # Wyczyść stare generacje (alias dla sudo nix-collect-garbage -d)
nol              # Lista generacji
nor              # Cofnij do poprzedniej generacji
nixsync          # Synchronizuj konfigurację z GitHub
```

### Gaming
```bash
gamemoderun <gra>         # Uruchom grę z GameMode
mangohud <gra>            # Uruchom grę z nakładką MangoHud
radeontop                 # Monitoruj użycie GPU AMD
gamemoded -s              # Sprawdź status GameMode
```

### Monitoring
```bash
htop                      # Monitor CPU/RAM
radeontop                 # Monitor GPU
sensors                   # Monitoring temperatury
acpi                      # Status baterii
powertop                  # Analiza zużycia energii
```

## 🎯 Konfiguracja gamingu

### Lutris
1. Zainstaluj grę przez Lutris
2. Kliknij prawym → Configure
3. System options → Enable GameMode ✅
4. Uruchom grę - GameMode aktywuje się automatycznie!

### Heroic Games Launcher
1. Settings → Advanced
2. Enable GameMode ✅
3. Enable MangoHud dla nakładki FPS

### Ręczne uruchamianie
```bash
gamemoderun mangohud ./twoja-gra
```

## 🔧 Funkcje Handheld Daemon

`handheld-daemon` zapewnia:
- **Wsparcie kontrolerów** - kontrolery Legion Go działają jak standardowe gamepady
- **Kontrola TDP** - regulacja limitów mocy (10W-30W)
- **Kontrola wentylatora** - ręczne lub automatyczne krzywe wentylatora
- **QAM** - Quick Access Menu (naciśnij przycisk Legion)
- **Wsparcie żyroskopu** - dla kontroli ruchowej

Dostęp do ustawień: Naciśnij **przycisk Legion** lub sprawdź ustawienia systemowe.

## 🐛 Rozwiązywanie problemów

### Zła orientacja ekranu
```bash
# Dla Wayland (KDE)
kscreen-doctor output.eDP-1.rotation.normal  # lub: left, right, inverted
```

### Ekran dotykowy nie działa
```bash
# Sprawdź urządzenia
xinput list

# Testuj dotyk
evtest
```

### GameMode się nie aktywuje
```bash
# Sprawdź status
gamemoded -s

# Sprawdź logi
journalctl -u gamemode -f
```

### Bateria zbyt szybko się rozładowuje
```bash
# Sprawdź zużycie energii
powertop

# Użyj governora powersave
sudo nano /etc/nixos/boot.nix
# Ustaw: cpuFreqGovernor = "powersave";
sudo nixos-rebuild switch
```

## 📚 Zasoby

- [Podręcznik NixOS](https://nixos.org/manual/nixos/stable/)
- [Dokumentacja Handheld Daemon](https://github.com/hhd-dev/hhd)
- [Legion Go na Linuksie](https://www.reddit.com/r/LegionGo/)
- [Arch Wiki - Legion Go](https://wiki.archlinux.org/title/Lenovo_Legion_Go)

## 🤝 Współpraca

Zachęcam do:
- Zgłaszania problemów
- Sugerowania ulepszeń
- Dzielenia się swoimi optymalizacjami

## 📄 Licencja

Licencja MIT - możesz swobodnie używać i modyfikować!

## 🙏 Podziękowania

- [NixOS](https://nixos.org/) - Deklaratywna dystrybucja Linuksa
- [Handheld Daemon](https://github.com/hhd-dev/hhd) - Wsparcie kontrolerów Legion Go
- Społeczność Legion Go na Reddit i Discord

## 📮 Kontakt

- GitHub: [@szpila3-ship-it](https://github.com/szpila3-ship-it)

---

**Miłego grania na Legion Go z NixOS!** 🎮✨
