{ config, pkgs, ... }:

{
  # Import additional configuration files
  imports = [
    ./home-manager-configs/packages.nix
    ./home-manager-configs/git.nix
    ./waybar.nix
    ./hyprland.nix
    
  ];
 
  home.username = "ijadux2";
  home.homeDirectory = "/home/ijadux2";


  home.stateVersion = "25.05";

  services.flatpak.enable = true;
 
  home.packages = [
  git
  curl
  wget
  vscode 
  neofetch
  nitch
  brave
  rofi-wayland
  kitty
  micro
# Hyprland essentials
    hyprland waybar swaync swayidle wl-clipboard grim slurp wf-recorder wlogout swaybg wlsunset

    # Hyprland utilities
    dunst rofi-wayland kitty mako xdg-desktop-portal-hyprland polkit_gnome gnome.adwaita-icon-theme

    # Miscellaneous utilities
    brightnessctl playerctl pamixer networkmanagerapplet blueman wget curl htop tree ripgrep fd bat exa jq fzf

  ];

 
  home.file = {
   
  };

 
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}

programs.git = {
    enable = true;
    userName = "ijadux2";
    userEmail = "kv26102009@gmil.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

   programs.bash = {
    enable = true;
    shellAliases = {
      ll = "exa -l --git";
      la = "exa -la --git";
      grep = "rg";
      cat = "bat";
    };
  };

  systemd.user.services = {
    polkit-gnome-agent = {
      Unit.Description = "Polkit Authentication Agent";
      Service.ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

   # Environment variables
  home.sessionVariables = {
    # Wayland environment 
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    CLUTTER_BACKEND = "wayland";
    # Fix for NixOS issues on Ubuntu
    NIXOS_OZONE_WL = "1";
  };

   # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Monitor setup (configure as needed)
      monitor=,highres,auto,1

      environment.sessionVariables = {
   If your cursor becomes invisible
   WLR_NO_HARDWARE_CURSORS = "1";
   Hint electron apps to use wayland
   NIXOS_OZONE_WL = "1";
   };

  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  jack.enable = true;
  };

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

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };

  home.file.".config/starship.toml".source = ./starship.toml;
}
