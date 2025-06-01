{ config, pkgs, pkgs-unstable, nur, inputs, ... }:

{
	# home manager needs a bit of information about you and the paths it should
	# manage.
	home.username = "ndebruin";
	home.homeDirectory = "/home/ndebruin";

	imports = 
		(import ./desktop) ++ # WM/DE programs and config ONLY
		(import ./programs); # all other programs, TUI or GUI

	# This value determines the Home Manager release that your configuration is
	# compatible with. This helps avoid breakage when a new Home Manager release
	# introduces backwards incompatible changes.
	#
	# You should not change this value, even if you update Home Manager. If you do
	# want to update the value, then make sure to first check the Home Manager
	# release notes.
	home.stateVersion = "24.11"; # Please read the comment before changing.

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.pointerCursor = {
		name = "phinger-cursors-light";
		package = pkgs.phinger-cursors;
		size = 32;
		gtk.enable = true;
	};

	xdg.mimeApps.enable = true;
	xdg.mimeApps.defaultApplications = 
	{
		"text/html" = "firefox.desktop";
		"x-scheme-handler/http" = "firefox.desktop";
		"x-scheme-handler/https" = "firefox.desktop";
		"x-scheme-handler/about" = "firefox.desktop";
		"x-scheme-handler/unknown" = "firefox.desktop";
	};
	
	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#   org.gradle.console=verbose
		#   org.gradle.daemon.idletimeout=3600000
		# '';
	};

	programs.git = {
		enable = true;
		userName = "Nic DeBruin";
		userEmail = "nzdebruin@gmail.com";
		extraConfig.credential = {
			helper = "manager";
			credentialStore = "cache";
			"https://github.com".username = "ndebruin";
		};
	};

	programs.gpg = {
		enable = true;
	}; 

	services.gpg-agent = {
		enable = true;
		pinentryPackage = pkgs.pinentry-qt;
	};
	
	# these are only crucial things for our profile / repo management
	home.packages = with pkgs; [
		git
		git-crypt
		git-credential-manager
		gnupg
		pinentry-qt 
		bash
	];

	services.mpris-proxy.enable = true; # enable bluetooth command support

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. If you don't want to manage your shell through Home
	# Manager then you have to manually source 'hm-session-vars.sh' located at
	# either
	#
	#  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#  /etc/profiles/per-user/ndebruin/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
		EDITOR = "nano";
		DEFAULT_BROWSER = "firefox";
	};

}
