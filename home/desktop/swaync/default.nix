{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    nerdfonts
    swaynotificationcenter
  ];
  
  xdg.configFile."swaync/config.json".source = ./config.json;
  # xdg.configFile."swaync/style.css".source = ./style.css;
}