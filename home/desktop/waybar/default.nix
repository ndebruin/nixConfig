{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    font-awesome
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings.".config/waybar/config.jsonrc".source = ./config.jsonrc;
    style = ./style.css;
    systemd.enable = false;
  };
  home.file.".config/waybar/config.jsonrc".source = ./config.jsonrc;
  home.file.".config/waybar/power_menu.xml".source = ./power_menu.xml;
  # home.file.".config/waybar/style.css".source = ./style.css;
}