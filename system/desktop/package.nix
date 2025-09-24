{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      veracrypt
      # other stable packages
    ])
    ++ (with pkgs-unstable; [
      heroic
      beeper
      # other unstable packages
    ])
    ++ [
      inputs.nvf-config.packages.${pkgs.system}.default
      inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    ];
}
