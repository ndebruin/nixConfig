{pkgs, ...}:
{
        home.packages = with pkgs; [


                # terminal utils / programs
                iperf
                zip
                unzip
                gnutar
                git
                gh
                wget
                curl
                dig
                htop
                gtop
                btop
                parted
                unixtools.fdisk
                nix-search-cli
                neofetch
                python3
		killall
		minicom
	];
}
