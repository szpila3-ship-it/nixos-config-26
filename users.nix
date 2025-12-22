{ config, pkgs, ... }:

{
  users.users.draxmen = {
    isNormalUser = true;
    group = "draxmen";
    description = "Main user";

    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "input"
    ];
  };

  users.groups.draxmen = {};
}
