# NixOS 26.05 – Lenovo Legion Go

Modułowa **konfiguracja NixOS 26.05** dla handhelda opartego na AMD  
(hardware klasy Lenovo Legion Go).

Ten repozytorium **nie zawiera żadnych sekretów** i jest bezpieczne do publikacji.

## Kluczowe cechy

- NixOS 26.05  
- KDE Plasma 6 (Wayland)  
- AMD GPU (amdgpu + RADV)  
- Stos do gamingu: GameMode, Gamescope, MangoHud  
- Handheld Daemon (hhd)  
- Home Manager poprzez moduł NixOS  

## Struktura katalogu `/etc/nixos`

- `flake.nix` — główny plik flake definiujący system i jego moduły  
- `configuration.nix` — główny plik konfiguracyjny systemu  
- `hardware-configuration.nix` — konfiguracja sprzętu wygenerowana przez `nixos-generate-config`, specyficzna dla urządzenia  
- `boot.nix` — konfiguracja startu systemu  
- `desktop.nix` — konfiguracja środowiska graficznego  
- `gaming.nix` — konfiguracja dedykowana gamingu  
- `networking.nix` — konfiguracja sieci  
- `locale.nix` — ustawienia lokalizacji i języka  
- `users.nix` — konfiguracja użytkowników  
- `packages.nix` — definicje pakietów systemowych  

## Uwagi

- `hardware-configuration.nix` jest specyficzny dla sprzętu i nie jest wersjonowany  
- Hasła użytkowników i klucze SSH konfigurowane lokalnie  
- Git korzysta z uwierzytelniania SSH  
- Korzystamy z Nix flakes dla łatwego zarządzania konfiguracją i rollbacku  
- Każdy obszar konfiguracji ma oddzielny plik dla lepszej czytelności i utrzymania porządku  
- Pakiety i opcje są aktualizowane do najnowszych dostępnych wersji  
- Komentarze w plikach pisane są po polsku, krótko i technicznie  

---

Wygenerowano przez asystenta.