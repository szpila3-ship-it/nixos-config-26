# Flake Hybryda do Gier

{
  description = "NixOS hybrid config - draxmen";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
  let
    system = "x86_64-linux";

    unstablePkgs = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.legion-go = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./configuration.nix

        # 👇 udostępniamy unstable jako pkgs.unstable
        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = unstablePkgs;
            })
          ];
        })
      ];
    };
  };
}
