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
    kdePackages.qttools
    kdePackages.qt3d
    kdePackages.qtdoc
    qtcreator # gui application
    qt6.full

    # clion
    jetbrains.clion
	];

}
