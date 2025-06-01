{ pkgs, config, inputs, lib, ... }:

{
  home.packages = with pkgs; [
    brightnessctl
  ];

  services.hypridle = { # idle manager
    enable = true;
    package = pkgs.hypridle;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid having to press button to turn on display
      };

      listener = [

        { # dim backlight
          timeout = 180; # 3 minutes
          on-timeout = "brightnessctl -s set 5%"; # set monitor backlight to 10%
          on-resume = "brightnessctl -r"; #restore
        }

        { # lock screen
          timeout = 600; # 10 minutes
          on-timeout = "loginctl lock-session"; # lock screen
        }

        { # screen off
          timeout = 630; #10.5 minutes
          on-timeout = "hyprctl dispatch dpms off"; # screen off
          on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on and resume brightness
        }

        { # sleep
          timeout = 900; # 15 minutes
          on-timeout = "systemctl suspend"; # suspend
        }

      ];
    };
  };
}
