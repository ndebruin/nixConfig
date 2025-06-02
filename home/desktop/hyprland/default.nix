{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    grim
    slurp
    hyprshot
    brightnessctl
    wl-clipboard
    cliphist
    hyprpolkitagent
    playerctl
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;


    # systemd.enable = true;
  };
  home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
}
