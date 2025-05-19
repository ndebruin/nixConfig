{ pkgs, config, inputs, lib, ... }:

{

  services.hyprpaper = { # wallpaper manager
    enable = true;
    package = pkgs.hyprpaper;

    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "/home/ndebruin/.dotfiles/home/desktop/wallpapers/dish.jpg"
      ];

      wallpaper = [
        " , /home/ndebruin/.dotfiles/home/desktop/wallpapers/dish.jpg"
      ];
    };
  };
}
