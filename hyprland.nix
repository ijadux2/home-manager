{ config, pkgs, ... }:

let
  keybinds = [
    { modifiers = [ "SUPER" ]; key = "Return"; command = "exec,kitty"; }
    { modifiers = [ "SUPER" ]; key = "Q"; command = "killactive"; }
    { modifiers = [ "SUPER" ]; key = "F"; command = "fullscreen"; }
    { modifiers = [ "SUPER" ]; key = "Space"; command = "exec,rofi-wayland -show drun"; }
    { modifiers = [ "SUPER" ]; key = "Left"; command = "movefocus,l"; }
    { modifiers = [ "SUPER" ]; key = "Right"; command = "movefocus,r"; }
    { modifiers = [ "SUPER" ]; key = "Up"; command = "movefocus,u"; }
    { modifiers = [ "SUPER" ]; key = "Down"; command = "movefocus,d"; }
  ];

  keybindLines = builtins.concatStringsSep "\n" (
    map (kb:
      "bind = ${builtins.concatStringsSep "+" kb.modifiers},${kb.key},${kb.command}"
    ) keybinds
  );
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Monitor setup (configure as needed)
      monitor=,highres,auto,1

      # Startup applications
      exec-once = waybar
      exec-once = swaync
      exec-once = swayidle -w
      exec-once = dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE
      exec-once = systemctl --user import-environment DISPLAY WAYLAND_DISPLAY HYPRLAND_INSTANCE_SIGNATURE
      exec-once = /usr/libexec/polkit-gnome-authentication-agent-1
      exec-once = wlsunset -t 4500 -T 6500
      exec-once = swaybg -m fill -i ~/.config/hypr/wallpaper.png

      # Input configuration
      input {
        kb_layout = us
        follow_mouse = 1
        touchpad {
          natural_scroll = yes
          tap-to-click = yes
        }
      }

      # Keybinds
      ${keybindLines}

      # General window rules
      general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)
        layout = dwindle
      }

      # Window rules
      windowrule = float, ^(pavucontrol)$
      windowrule = center, ^(pavucontrol)$
    '';
  };
}
