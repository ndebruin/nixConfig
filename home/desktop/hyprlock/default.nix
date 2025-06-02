{ pkgs, config, inputs, lib, ... }:

{
  programs.hyprlock = { # lockscreen manager
    enable = true;
    package = pkgs.hyprlock;
  };
  home.file.".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
}
