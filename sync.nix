{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
  ];

  environment.shellAliases = {
    nixsync = "cd /etc/nixos && git commit -am 'nixos update' && git push";
  };
}
