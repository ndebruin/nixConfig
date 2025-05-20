{pkgs, pkgs-unstable, ...}:
{
	programs.vscode = {
                enable = true;
                package = pkgs.vscode-fhs;
		userSettings = {
			"files.autoSave" = "off";
			"editor.tabSize" = 2;
		};
                extensions = with pkgs-unstable.vscode-extensions; [
                        # python
                        ms-python.python
                        ms-python.debugpy
                        ms-python.vscode-pylance
                        
                        # C/C++
                        ms-vscode.cpptools-extension-pack
			ms-vscode.cpptools
#                        ms-vscode.cpptools-themes
#                        twxs.cmake
                        ms-vscode.cmake-tools
                        
                        # nix support
                        jnoortheen.nix-ide

                        # misc
                        mechatroner.rainbow-csv
                        tomoki1207.pdf

			# remote dev
                        ms-vscode-remote.remote-ssh
			ms-vscode-remote.remote-ssh-edit
                ];
        };
}
