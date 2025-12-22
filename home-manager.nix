{ config, pkgs, ... }:

{
  home.username = "draxmen";
  home.homeDirectory = "/home/draxmen";

  home.stateVersion = "24.05"; # ZOSTAW 24.05

  programs.git = {
    enable = true;
    settings = {
      user.name = "draxmen";
      user.email = "you@example.com";
    };
  };

  programs.bash.enable = true;
  programs.zsh.enable = true;
}
