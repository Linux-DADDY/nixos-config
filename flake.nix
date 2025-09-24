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
    hyprpanel,
    nix-flatpak,
    split-monitor-workspaces,
    ayugram-desktop,
    ...
  } @ inputs: let
    # Import your declarative configuration
    declarative = import ./declarative.nix;

    # Use system from declarative config
    system = declarative.system;

    # Create unstable packages for the system
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations.${declarative.hostname} = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs declarative pkgs-unstable;
        # Pass disk path for disko if needed
        diskDevice = declarative.diskoPath;
      };

      modules = [
        # Global Config
        ./system/default.nix

        # Add disko module if you have disk configuration
        disko.nixosModules.disko

        # Add Hyprland if you're using it
        inputs.hyprland.nixosModules.default

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
              inherit inputs pkgs-unstable declarative;
              flake-inputs = inputs;
            };

            # Add impermanence module to home-manager.
            sharedModules = [
              impermanence.nixosModules.home-manager.impermanence
            ];

            users.${declarative.username} = {
              imports = [
                ./home/default.nix
                #impermanence.homeManagerModules.impermanence
                # nix-flatpak.homeManagerModules.nix-flatpak

                # Add Hyprland home-manager module if needed
                inputs.hyprland.homeManagerModules.default
              ];
            };
          };
        }
      ];
    };
  };
}
