{pkgs, pkgs-unstable, ...}:
{
  home.packages = with pkgs; [
    # generic build tools
    cmake
    ninja
    clang
    
    # WPI-HPRC ground station specific stuff
    kdePackages.qtbase
    kdePackages.qtserialport
    kdePackages.qtwebsockets
    qtcreator # gui application

    # clion
    jetbrains.clion
	];

}
