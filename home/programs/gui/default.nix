{pkgs, pkgs-unstable, ...}:
{
        home.packages = with pkgs; [

                # GUI programs
		arduino-ide
                qtcreator
                gimp
                webcord # alt discord client
                signal-desktop
                slack
                kicad
                kdePackages.kdenlive
                audacity
                prusa-slicer
                bambu-studio
                mpv # media player
                obs-studio
                kdePackages.okular # document viewer
                remmina # rdp client
                lollypop # music library player
                cheese # webcam
		tageditor # ID3 tag editor
		image-roll
		prismlauncher
		jetbrains.clion
	];
	services.kdeconnect.enable = true;
}
