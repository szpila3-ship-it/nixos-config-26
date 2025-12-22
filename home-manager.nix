{ config, pkgs, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.draxmen = {
    home.stateVersion = "26.05";

   programs.git = {
  enable = true;
  settings = {
    user.name = "draxmen";
    user.email = "you@example.com";
  };
};

    programs.bash.enable = true;
    programs.zsh.enable = true;
  };
}
