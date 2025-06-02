{ pkgs, config, inputs, lib, ... }:

{

  services.hyprpaper = { # wallpaper manager
    enable = true;
    package = pkgs.hyprpaper;
  };

  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
