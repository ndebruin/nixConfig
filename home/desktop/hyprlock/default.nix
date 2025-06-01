{ pkgs, config, inputs, lib, ... }:

{
  programs.hyprlock = { # lockscreen manager
    enable = true;
    package = pkgs.hyprlock;

    settings = {
      general = {
        hide_cursor = false;
        fail_timeout = 500;
      };

      background = [
        {
          path = "/home/ndebruin/.dotfiles/home/desktop/wallpapers/dish.jpg";
          blur_passes = 1;
          blur_size = 8;
        }
      ];

      auth = [
        # uncomment to enable fingerprint auth
        #{
        #  fingerprint.enabled = true;
        #  fingerprint.ready_message = "Scan fingerprint to unlock";
        #  fingerprint.present_message = "Scanning...";
        #  fingerprint.retry_delay = 250; # ms
        #}
        {
          pam.enabled = true;
          # pam.module = "hyprlock";
        }
      ];

      animations = [
        {
          enabled = true;
          # animation curves
          bezier = "linear, 1, 1, 0, 0";
          # animation config
          animation = [
            "fadeIn, 1, 0.1, linear"
            "fadeOut, 1, 1, linear"
            "inputFieldDots, 1, 2, linear"
          ];
        }
      ];

      input-field = [
        {
          size = "500, 15";
          monitor = "";
          outline_thickness = 5;
          
          # colors
          inner_color = "rgba(0,0,0,0.0)"; # no fill
          outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
          fail_color  = "rgba(ff6633ee) rbga(ff0055ee) 40deg";
          font_color  = "rgb(143, 143, 143)";

          fade_on_empty = true;
          rounding = 15;
          
#          font_family = "Monospace";
#          placeholder_text = "Input password...";
#          fail_text = "$PAMFAIL";

          dots_text_format = "*";
          dots_size = "5";
          dots_spacing = "0.3";

          hide_input = false;

          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      # DATE
      label = [
        { # DATE
          monitor = "";
          text = "cmd[update:60000] date +\"%A, %B %d %Y\""; # update every 60 seconds

          font_size = 25;

          position = "-30, -130";
          halign = "right";
          valign = "top";
        }
        { # TIME
          monitor = "";
          text = "$TIME";
          
          font_size = 90;

          position = "-30, 0";
          halign = "right";
          valign = "top";
        }
        { # USER
          monitor = "";
          text = "$USER";

          font_size = 20;
          position = "5, 5";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };
}
