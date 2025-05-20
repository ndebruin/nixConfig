{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries.PlatformIO = {
    name = "PlatformIO";
    genericName = "PlatformIO";
    exec = "/home/ndebruin/.dotfiles/home/programs/platformio/run.sh";
#    icon = "/path/to/icon.png";  # optional
    type = "Application";
    terminal = false;
    categories = [ "Development" ];
  };
}
