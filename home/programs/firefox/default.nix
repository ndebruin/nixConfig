{pkgs, pkgs-unstable, ...}:
{
    #home.packages = with pkgs; [
    #    firefox
    #];
    home.packages.firefox.enable = true;
}