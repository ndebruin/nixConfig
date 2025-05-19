{pkgs, pkgs-unstable, ...}:
{
        home.packages = with pkgs; [


                # GUI programs
                vscodium-fhs
                platformio
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
                cromite
	];
	services.kdeconnect.enable = true;
        imports = 
                import (./firefox.nix) ++
                import (./chrome.nix);
        
}
