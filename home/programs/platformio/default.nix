{ config, lib, pkgs, ... }:
{
  xdg.desktopEntries.PlatformIO = {
    name = "PlatformIO";
    genericName = "PlatformIO";
    exec = "nix run --impure github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode#codium --";
#    icon = "/path/to/icon.png";  # optional
    type = "Application";
    terminal = false;
    categories = [ "IDE" ];
  };
}
