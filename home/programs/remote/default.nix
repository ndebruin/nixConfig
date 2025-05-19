{pkgs, ...}:
{
        home.packages = with pkgs; [

 		# wpi vpn client bits
                gpclient 
                openconnect
                networkmanager-openconnect

		# home vpn bits
                wireguard-tools
                wg-netmanager

	];
}
