{ config, pkgs, ... }:

{
  # Skrypt do RĘCZNEJ synchronizacji konfiguracji z GitHub
  # Użycie: sudo nixos-sync
  environment.systemPackages = with pkgs; [
    (writeScriptBin "nixos-sync" ''
      #!/usr/bin/env bash
      set -e
      
      REPO_DIR="/home/draxmen/nixos-config"
      
      echo "📦 Synchronizing NixOS configuration to GitHub..."
      
      # Skopiuj wszystkie .nix oprócz hardware-configuration.nix
      cd /etc/nixos
      for file in *.nix; do
        if [ "$file" != "hardware-configuration.nix" ]; then
          cp "$file" "$REPO_DIR/"
        fi
      done
      
      # Zmień właściciela
      chown -R draxmen:users "$REPO_DIR"
      
      # Git operations
      cd "$REPO_DIR"
      sudo -u draxmen ${pkgs.git}/bin/git add .
      
      if sudo -u draxmen ${pkgs.git}/bin/git diff --staged --quiet; then
        echo "✅ No changes to commit"
        exit 0
      fi
      
      sudo -u draxmen ${pkgs.git}/bin/git commit -m "Update: $(date '+%Y-%m-%d %H:%M:%S')"
      sudo -u draxmen ${pkgs.git}/bin/git push origin main
      
      echo "✅ Configuration synced to GitHub!"
    '')
  ];
}
