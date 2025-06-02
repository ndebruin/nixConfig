{pkgs, inputs, ...}:
{
  home.packages = with pkgs; [
    upower
    playerctl
    acpi
    lm_sensors
    sysstat
    networkmanagerapplet
    brightnessctl
    dconf
    qt6ct
    blueman 
    lightly-qt
    kitty
    nwg-look #gtk setting editor
    nemo-with-extensions
    gvfs # this enables trash and network support in nemo
    seahorse # gnome provided keyring gui
    gedit # text editor
    gnome-calculator
#    kdePackages.partitionmanager
    pavucontrol
    udiskie # handles automatic mounting of portable drives
#    udisks2 # handles automatic mounting of portable drives
  ];


}
