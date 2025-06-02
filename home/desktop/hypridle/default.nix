{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
  ];

  services.hypridle = { # idle manager
    enable = true;
    package = pkgs.hypridle;
  };

  home.file.".config/hypr/hypridle.conf".source = ./hypridle.conf;
}
