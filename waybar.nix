{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];
        "clock" = {
          format = "{:%a %d %b %H:%M}";
        };
        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        "network" = {
          format-wifi = " {essid}";
          format-ethernet = " {ipaddr}";
          format-disconnected = "";
        };
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-icons = [ "" "" "" ];
        };
      };
    };
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
      }
      window#waybar {
        background: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
      }
      #clock {
        font-weight: bold;
      }
    '';
  };
}