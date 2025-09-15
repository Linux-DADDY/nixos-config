{pkgs, ...}: {
  home.packages = with pkgs; [
    rofi-wayland
  ];

  # Rofi BIN
  home.file.".config/hypr/rofi/bin/asroot".text = builtins.readFile ./bin/asroot;
  home.file.".config/hypr/rofi/bin/clipboard".text = builtins.readFile ./bin/clipboard;
  home.file.".config/hypr/rofi/bin/confirm".text = builtins.readFile ./bin/confirm;
  home.file.".config/hypr/rofi/bin/launcher".text = builtins.readFile ./bin/launcher;

  # home.file.".config/hypr/rofi/bin/powermenu".text = builtins.readFile ./bin/powermenu;
  home.file.".config/hypr/rofi/bin/powermenu".text = builtins.readFile ./bin/powermenu;
  # executable = true;

  home.file.".config/hypr/rofi/bin/screenshot".text = builtins.readFile ./bin/screenshot;
  home.file.".config/hypr/rofi/bin/windows".text = builtins.readFile ./bin/windows;

  # Rofi Themes
  home.file.".config/hypr/rofi/themes/asroot.rasi".text = builtins.readFile ./themes/asroot.rasi;
  home.file.".config/hypr/rofi/themes/clipboard.rasi".text = builtins.readFile ./themes/clipboard.rasi;
  home.file.".config/hypr/rofi/themes/colors.rasi".text = builtins.readFile ./themes/colors.rasi;
  home.file.".config/hypr/rofi/themes/launcher.rasi".text = builtins.readFile ./themes/launcher.rasi;
  home.file.".config/hypr/rofi/themes/powermenu.rasi".text = builtins.readFile ./themes/powermenu.rasi;
  home.file.".config/hypr/rofi/themes/screenshot.rasi".text = builtins.readFile ./themes/screenshot.rasi;

  # Rofi Confirmation
  home.file.".config/hypr/rofi/themes/confirmation/askpass.rasi".text = builtins.readFile ./themes/confirmation/askpass.rasi;
  home.file.".config/hypr/rofi/themes/confirmation/confirm.rasi".text = builtins.readFile ./themes/confirmation/confirm.rasi;
}
