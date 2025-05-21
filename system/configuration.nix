# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # add features for nix flakes
  # nix.package = pkgs.nixFlakes;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
	hostName = "nixos-dev2";
	networkmanager.enable = true;

	# configure proxy if needed
        # proxy.default = "http://user:password@proxy:port/";
	# proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # set internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";  

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      #font-awesome_5
      noto-fonts-cjk-sans
      nasin-nanpa
      meslo-lgs-nf
      atkinson-hyperlegible
      # opengothic
      # udev-gothic
      # yasashisa-gothic
      roboto
    ];
    fontDir.enable = true;
  };

  # this brings in the base of hyprland and a lot of it's support components
  # then home-manager configures hyprland for your specific user
  programs.hyprland.enable = true;

#  programs.nix-ld.dev.enable = true;

  hardware.bluetooth = {
    enable = true; # enable bluetooth support
    powerOnBoot = false; # don't start up bluetooth modem on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      load-module module-switch-on-connect
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
    '';
  };
  
  # list services that you want to enable
  services = {

    # Enable CUPS to print documents.
    printing.enable = true;

    # allow automounting disks
    udisks2.enable = true;

    # Enable sound.
    pipewire = {
      enable = false;
#      audio.enable = true;
#      alsa.enable = true;
#      alsa.support32Bit = true;
#      pulse.enable = true;
#      jack.enable = true;
#      wireplumber.extraConfig.bluetoothEnhancements = {
#        "monitor.bluez.properties" = {
#          "bluez5.enable-sbc-xq" = true;
#          "bluez5.enable-msbc" = true;
#          "bluez5.enable-hw-volume" = true;
#          "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
#        };
#      };
    };

    # Enable the OpenSSH daemon.
    openssh = {
    enable = false;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
      };
    };

    dbus.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    # fingerprint support
    # fprintd = {
      # enable = true;
      # tod = {
        # enable = true;
        # driver = pkgs.libfprint-2-tod1-vfs0090;
      # };
    # };
 
    # expose power management calls to applications
    upower.enable = true;

    # udev help
    #udev.packages = [
    #	pkgs-unstable.platformio-core
    #	pkgs-unstable.openocd
    #];
    udev.extraRules = ''
      # UDEV rules for Teensy USB devices
      ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1"
      ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789a]*", ENV{MTP_NO_PROBE}="1"
      KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666""
      KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
      SUBSYSTEMS=="usb", ATTRS{idVendor}=="1fc9", ATTRS{idProduct}=="013*", MODE:="0666"
    '';

    # power management configs
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 60;

        #Optional helps save long term battery health
        # START_CHARGE_THRESH_BAT0 = 75; # 75 and bellow it starts to charge
        # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # libinput.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ndebruin = {
     isNormalUser = true;
     description = "Nic DeBruin";
     extraGroups = [ "wheel" "tty" "networkmanager" "dialout" "usb" "plugdev" "audio" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; []; #packages are managed by home-manager
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    nano
    dig
    wget
    man-pages
    man-pages-posix
    aspellDicts.en
    epapirus-icon-theme
    git
    gnupg
    git-crypt
  ];

  environment.wordlist.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  #security.rtkit.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
    wlr = {
      enable = true;
  #    settings = {
  #      screencast = {
  #        output_name = "eDP-1";
  #        max_fps = 30;
  #        chooser_type = "simple";
  #        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #      };
  #    };
    };
    config.common.default = "*";
  };
  xdg.icons.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
	enable = true;
	allowedTCPPorts = [ ];
	allowedUDPPorts = [ ];
	allowedTCPPortRanges = [ 
		{ from = 1714; to = 1764; } # KDE CONNECT
	];
	allowedUDPPortRanges = [
		{ from = 1714; to = 1764; } # KDE CONNECT
	];
  };


  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

