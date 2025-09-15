{
  description = "Flake for global config, Home-Manager, Secureboot, Unstable packages, hyprland and SDDM and more.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    agenix.url = "github:ryantm/agenix";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    nvf-config.url = "github:Linux-DADDY/nvf-config";
    #nvf-config.url = "github:rice-cracker-dev/nvf-config";

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    ayugram-desktop = {
      type = "git";
      submodules = true;
      url = "https://github.com/ndfined-crp/ayugram-desktop/";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    chaotic,
    home-manager,
    disko,
    impermanence,
    agenix,
    hyprpanel,
    nix-flatpak,
    split-monitor-workspaces,
    ayugram-desktop,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    username = "Linux-DADDY";
    hostname = "nixos";

    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs pkgs-unstable username hostname system;
        };

        modules = [
          # Global Config
          ./system/default.nix
          {
            environment.systemPackages = [agenix.packages.${system}.default];
          }

          #Declearative Password
          agenix.nixosModules.default

          # Chaotic
          chaotic.nixosModules.nyx-cache
          chaotic.nixosModules.nyx-overlay
          chaotic.nixosModules.nyx-registry

          # Flatpak
          nix-flatpak.nixosModules.nix-flatpak

          # Impermanence
          impermanence.nixosModules.impermanence

          # Home manager on flakes
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              extraSpecialArgs = {
                inherit inputs pkgs-unstable username;
                flake-inputs = inputs;
              };

              users.${username} = {
                imports = [
                  ./home/default.nix
                  impermanence.homeManagerModules.impermanence
                  # nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            };
          }
        ];
      };
    };
  };
}
