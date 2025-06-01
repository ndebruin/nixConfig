{pkgs, pkgs-unstable, ...}:
{
        home.packages = with pkgs; [

                # GUI programs
		arduino-ide
                gimp
                webcord # alt discord client
                signal-desktop
                slack
                kdePackages.kdenlive
                audacity
                prusa-slicer
                bambu-studio
                obs-studio
                kdePackages.okular # document viewer
                remmina # rdp client
                lollypop # music library player
                cheese # webcam
		tageditor # ID3 tag editor
		image-roll
		prismlauncher # minecraft launcher
                vlc
	];
	services.kdeconnect.enable = true;
}
