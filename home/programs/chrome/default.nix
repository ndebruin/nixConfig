{pkgs, pkgs-unstable, ...}:
{
  home.packages = with pkgs; [
    chromium
  ];
}