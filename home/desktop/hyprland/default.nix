{ pkgs, config, inputs, lib, ... }:

{
#  imports = [
#    nix-colors.homeManagerModules.default
#  ];

 # colorScheme = nix-colors.lib.schemeFromYAML "wall-color" (builtins.readFile  ../wallpapers/colors/color.yaml);

  home.packages = with pkgs; [
    grim
    slurp
    hyprshot
    brightnessctl
    wl-clipboard
    cliphist
    hyprpolkitagent
  ];

#  services.hyprpolkitagent.enable = true; # privilege escalation UIs

  gtk = {
    enable = true;
    font.name = "TeX Gyre Adventor 10";
    theme = {
      name = "Nordic-darker";
      package = pkgs.nordic;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    };

    gtk4.extraConfig = {
    Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
    };
  
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;


    settings = {
      "$terminal" = "kitty";
      "$fileManager" = "nemo";
      "$menu" = "fuzzel";
      "$code" = "codium";
      "$browser" = "firefox";
      "$editor" = "gedit";
          
      monitor=
        [
  
        ];

      env = [
        "HYPRCURSOR_THEME,phinger-cursors-dark"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR,phinger-cursors-dark"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "NIXOS_OZONE_WL, 1"
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_CURRENT_DESKTOP, Hyprland"
      ];

#####################################################################################
##################################    Bindings    ###################################
#####################################################################################
      
      "$mainMod" = "SUPER";
      "$shiftKey" = "SHIFT";
      "$alttKey" = "ALT";

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm =
        [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

      bind =
        [
          # window controls
          "$alttKey, F4, killactive"
          "$mainMod, Q, exec, hyprctl activewindow |grep pid |tr -d 'pid:'|xargs kill"
          "$mainMod, F, fullscreen"
          "$mainMod, space, togglefloating"
          "$mainMod, S, togglesplit" # dwindle
          "$mainMod $shiftKey, A, pin" # Keep above
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod SHIFT, left, movewindow, l"
          "$mainMod SHIFT, right, movewindow, r"
          "$mainMod SHIFT, up, movewindow, u"
          "$mainMod SHIFT, down, movewindow, d"
          "$mainMod $alttKey, left, splitratio, -0.05"
          "$mainMod $alttKey, right, splitratio, 0.05"
#          "$mainMod, mouse_down, workspace, e+1"
#          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod, Escape, workspace, previous"
          "$alttKey, Tab, cyclenext"
          "$alttKey, Tab, bringactivetotop"
          "$alttKey SHIFT, Tab, cyclenext, prev"
          "$mainMod, Tab, workspace, next"
          "$mainMod SHIFT, Tab, workspace, previous"

#          ", xf86Display, movecurrentworkspacetomonitor, +1"

          # volume controls
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

          # applications
          "$mainMod, return, exec, kitty"
          "$mainMod, e, exec, nemo"
          "$mainMod, b, exec, firefox"
          
          # screenshots
          "$mainMod, PRINT, exec, hyprshot -o ~/pictures/screenshots -m region"
          "$mainMod SHIFT, PRINT, exec, hyprshot -o ~/pictures/screenshots -m window"
          " , PRINT, exec, hyprshot -o ~/pictures/screenshots -m output"


          # lock shortcut
          "$mainMod, l, exec, hyprlock"
          # logout shortcut
          "$mainMod SHIFT, m, exec, hyprctl dispatch exit"

          # notification center shortcut
          "$mainMod, n, exec, swaync-client -t -sw"

          # clipboard history shortcut
          "$mainMod, V, exec, cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"

          ]

        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
              x: let
                ws = let
                  c = (x + 1) / 10;
                in
                  builtins.toString (x + 1 - (c * 10));
              in [
                "$mainMod, ${ws}, workspace, ${toString (x + 1)}"
                "$mainMod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        )
         ;
      binde =
        [
          # volume controls
          ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- "
          "$mainMod, xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          "$mainMod, xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- "

          # brightness controls
          ", xf86monbrightnessup, exec, brightnessctl set 5%+"
          ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
        ];
      bindr =
        [
          # program launcher
          "$mainMod, Super_L, exec, pkill fuzzel || fuzzel"
        ];
      

#####################################################################################
##################################    Variables    ##################################
#####################################################################################

      input = {
        kb_layout = "us";
        kb_options = "grp:alt_shift_toggle";
        follow_mouse = 2;
        touchpad.natural_scroll = false;
        sensitivity = 0;
      };

      general = {
        gaps_in = 4;
        gaps_out = 6;
        border_size = 2;
        "col.active_border" = "rgba(a34b25FF)";
#        "col.active_border" = "rgb(${config.colorScheme.palette.base0E}) rgb(${config.colorScheme.palette.base0F}) 45deg";
#        "col.inactive_border" = "rgb(${config.colorScheme.palette.base00})";
	"col.inactive_border" = "rgba(0000ff7f)";
        layout = "dwindle";
      };

      
      decoration = {
          
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          fullscreen_opacity = 1.0;
          # Blur rules
          rounding = 5;
      
          blur = {
              enabled = true;
              size = 3;
              passes = 2;
              noise = 0.05;
              new_optimizations = true;
              brightness = 0.4;
              ignore_opacity = true;
              xray = false;
              popups = true;
              popups_ignorealpha = 1;
          };
      
          # blur_xray = false
          # Shadow
          # drop_shadow = true;
          # shadow_range = 30;
          # shadow_render_power = 3;
          # "col.shadow" = "rgba(01010144)";
          
          # Dim
#          dim_inactive = true;
#          dim_strength = 0.1;
#          dim_special = 0;
      };
    
      animations = {
          enabled = true;
      
          # Animation curves
          bezier = 
            [
              "md3_standard, 0.2, 0.0, 0, 1.0"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshoot, 0.05, 0.9, 0.1, 1.05"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "bounce, 0.4, 0.05, 0, 1.1"
              "test, 2, 1.25, -0.5, -1"
              "funky, 0.46, 0.35, -0.2, 1.2"
            ];
          # Animation configs
          animation = 
            [
              "windows, 1, 2, overshoot, slide"
              "border, 1, 1, default"
              "workspaces, 1, 2, overshoot, slide"
              "fadeIn, 1, 5, md3_decel"
              "fadeOut, 1, 5, md3_decel"
              "layers, 1, 0.2, default"
            ];
      
      };
      
      #dwindle = {
      #    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      #    pseudotile = true;
      #    preserve_split = true;
      #    # special_scale_factor = 1;
      #    # permanent_direction_override = true;
      #    # split_width_multiplier = 1;
      #    # force_split = 1;
      #    # preserve_split = true;
      #    # smart_resizing = false;
      #};
      
      #master = {
      #    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      #    allow_small_split = true;
      #    special_scale_factor = 1;
      #    mfact = 0.5;
      #    new_on_top = false;
      #    # orientation = "right";
      #    # always_center_master = true;
      #};
      
      #gestures = {
      #    workspace_swipe = true;
      #    workspace_swipe_invert = false;
      #    # workspace_swipe_distance = 100;
      #    workspace_swipe_cancel_ratio = 0.1;
      #    # workspace_swipe_numbered = true;
      #    workspace_swipe_create_new = false;
      #};
      
      misc = {
          disable_hyprland_logo = true;
          force_default_wallpaper = 0;
      };

#####################################################################################
##################################    Start up    ###################################
#####################################################################################

      exec-once = 
        [
          "pkill waybar || waybar -c ~/.config/waybar/config.jsonrc -s ~/.config/waybar/style.css"
          "pkill swaync || swaync"
          "nm-applet -sm-disable"
          "blueman-applet"
          "killall xfce4-notifyd"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "wl-paste --watch cliphist store"
          "systemctl --user start hyprpolkitagent"
          "udiskie"
        ];

    };
  };
}
