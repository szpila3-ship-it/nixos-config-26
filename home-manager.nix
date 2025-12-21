{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball 
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
    # ↑ Zmienione z release-24.05 na master
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.draxmen = { pkgs, lib, ... }: {
    home.stateVersion = "24.05";
    
    # Wyłącz sprawdzanie wersji Home Manager vs Nixpkgs
    home.enableNixpkgsReleaseCheck = false;

    # ═══════════════════════════════════════════════════════════
    # PAKIETY PER-USER
    # ═══════════════════════════════════════════════════════════
    home.packages = with pkgs; [
      # Narzędzia CLI
      htop
      btop
      tree
      ripgrep
      fd
      bat
      eza  # modern ls
      
      # Dodatkowe narzędzia deweloperskie
      # vscode
      # jetbrains.idea-community
    ];

    # ═══════════════════════════════════════════════════════════
    # BASH CONFIGURATION
    # ═══════════════════════════════════════════════════════════
    programs.bash = {
      enable = true;
      
      shellAliases = {
        # System
        ll = "ls -la";
        la = "eza -la --icons";
        
        # NixOS - zarządzanie systemem
        nos = "sudo nixos-rebuild switch";              # Rebuild systemu
        noc = "sudo nix-collect-garbage -d";            # Wyczyść stare generacje
        nol = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";  # Historia
        nor = "sudo nixos-rebuild switch --rollback";   # Rollback do poprzedniej
        
        # Aliasy kompatybilne
        nixup = "sudo nixos-rebuild switch";
        nixsync = "sudo nixos-sync";
        nixclean = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
        
        # Git shortcuts
        gs = "git status";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gl = "git log --oneline --graph";
      };
      
      bashrcExtra = ''
        # Prompt z kolorami
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        
        # Historia
        export HISTSIZE=10000
        export HISTFILESIZE=20000
        export HISTCONTROL=ignoredups:erasedups
        
        # Kolorowe man pages
        export LESS_TERMCAP_mb=$'\e[1;32m'
        export LESS_TERMCAP_md=$'\e[1;32m'
        export LESS_TERMCAP_me=$'\e[0m'
        export LESS_TERMCAP_se=$'\e[0m'
        export LESS_TERMCAP_so=$'\e[01;33m'
        export LESS_TERMCAP_ue=$'\e[0m'
        export LESS_TERMCAP_us=$'\e[1;4;31m'

        #Fastfetch
        fastfetch
      '';
    };

    # ═══════════════════════════════════════════════════════════
    # GIT CONFIGURATION
    # ═══════════════════════════════════════════════════════════
    programs.git = {
      enable = true;
      
      settings = {
        user.name = "Draxmen";
        user.email = "szpila3@gmail.com";
        
        init.defaultBranch = "main";
        pull.rebase = false;
        core.editor = "vim";
        color.ui = true;
        
        # Użyteczne aliasy
        alias = {
          co = "checkout";
          br = "branch";
          ci = "commit";
          st = "status";
          unstage = "reset HEAD --";
          last = "log -1 HEAD";
          visual = "log --graph --oneline --all";
        };
      };
    };

    # ═══════════════════════════════════════════════════════════
    # VIM CONFIGURATION
    # ═══════════════════════════════════════════════════════════
    programs.vim = {
      enable = true;
      
      settings = {
        number = true;
        relativenumber = true;
        expandtab = true;
        tabstop = 2;
        shiftwidth = 2;
      };
      
      extraConfig = ''
        syntax on
        set background=dark
        set mouse=a
        set clipboard=unnamedplus
        
        " Wyszukiwanie
        set incsearch
        set hlsearch
        set ignorecase
        set smartcase
        
        " Interfejs
        set ruler
        set showcmd
        set wildmenu
        set cursorline
      '';
    };

    # ═══════════════════════════════════════════════════════════
    # KDE PLASMA - Session Management
    # ═══════════════════════════════════════════════════════════
    
    # Skrypty uruchamiane przy starcie sesji
    home.file.".config/autostart/restore-session.desktop".text = ''
      [Desktop Entry]
      Type=Application
      Name=Restore KDE Session
      Exec=${pkgs.kdePackages.kconfig}/bin/kwriteconfig6 --file ksmserverrc --group General --key loginMode restoreSavedSession
      Hidden=false
      NoDisplay=true
      X-KDE-autostart-phase=1
    '';

    # Konfiguracja KDE - zapisywanie sesji
    home.file.".config/ksmserverrc".text = ''
      [General]
      loginMode=restoreSavedSession
      confirmLogout=true
      offerShutdown=true
      shutdownType=0
    '';

    # Konfiguracja KWin - window management
    home.file.".config/kwinrc".text = ''
      [Windows]
      Placement=Smart
      
      [Desktops]
      Number=1
      
      [Effect-DesktopGrid]
      BorderActivate=9
      
      [Plugins]
      kwin4_effect_translucencyEnabled=true
      
      [TabBox]
      LayoutName=thumbnail_grid
    '';

    # ═══════════════════════════════════════════════════════════
    # DOTFILES I PLIKI KONFIGURACYJNE
    # ═══════════════════════════════════════════════════════════
    
    # .vimrc (jeśli wolisz tradycyjny plik)
    home.file.".vimrc".text = ''
      " Managed by Home Manager
      " Additional vim config here
    '';

    # .inputrc dla lepszej historii w terminalu
    home.file.".inputrc".text = ''
      # Wyszukiwanie w historii strzałkami
      "\e[A": history-search-backward
      "\e[B": history-search-forward
      
      # Uzupełnianie bez rozróżniania wielkości liter
      set completion-ignore-case on
      set show-all-if-ambiguous on
      set mark-symlinked-directories on
    '';

    # ═══════════════════════════════════════════════════════════
    # ZMIENNE ŚRODOWISKOWE
    # ═══════════════════════════════════════════════════════════
    home.sessionVariables = {
      EDITOR = "vim";
      VISUAL = "vim";
      BROWSER = "firefox";
      TERMINAL = "konsole";
    };

    # ═══════════════════════════════════════════════════════════
    # XDG DIRECTORIES
    # ═══════════════════════════════════════════════════════════
    xdg.enable = true;
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Pulpit";
      documents = "$HOME/Dokumenty";
      download = "$HOME/Pobrane";
      music = "$HOME/Muzyka";
      pictures = "$HOME/Obrazy";
      videos = "$HOME/Wideo";
    };
  };

  # ═══════════════════════════════════════════════════════════
  # HOME MANAGER GLOBAL OPTIONS
  # ═══════════════════════════════════════════════════════════
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
}
