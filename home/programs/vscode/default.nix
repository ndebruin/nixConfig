{pkgs, pkgs-unstable, ...}:
{
programs.vscode = {
                enable = true;
                package = pkgs.vscode;
                extensions = with pkgs.vscode-extensions; [
                        # python
                        ms-python.python
                        ms-python.debugpy
                        ms-python.vscode-pylance
                        
                        # platformIO
                        platformio-platformio-ide
                        seryibaran.platformio-big-buttons

                        # C/C++
                        ms-vscode.cpptools
                        ms-vscode.cpptools-themes
                        twxs.cmake
                        ms-vscode.cmake-tools
                        
                        # nix support
                        jnoortheen.nix-ide

                        # misc
                        mechatroner.rainbow-csv
                        mathematic.vscode-pdf
                        ms-vscode-remote.remote-ssh
                ];
        };
}