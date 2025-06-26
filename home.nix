{ config, pkgs, inputs, ... }:

{
  programs = {
    home-manager = { enable = true; };
    nushell = {
      enable = true;
      shellAliases = {
        "cd" = "z";
        "cd.." = "z ..";
        ".." = "z ..";
        "g" = "git";
        "ll" = "ls -l";
        "clear" = "nu";
        "cls" = "nu";
        "rebuild" =
          "sudo nixos-rebuild switch --flake ~/dot"; # todo: add nom support?
        "update" = "nix flake update --flake ~/dot";
        "dev" = "nix-shell --command 'nu'";
      };
      settings = {
        show_banner = false;
        completions.external = {
          enable = true;
          max_results = 200;
        };
      };
      extraConfig = ''
        # startup
        # fastfetch
      '';
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      settings = { add_newline = true; };
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
    fastfetch = { enable = true; };
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/lucas/dot/flake.nix";
    };
    git = {
      enable = true;
      userEmail = "lucas@somfic.dev";
      userName = "Lucas";
    };
    gh = { enable = true; };
    vscode = { enable = true; };
    kitty = { enable = true; };
    waybar = { enable = true; };
    rofi = { enable = true; };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
    settings = {
      "$mod" = "SUPER";
      cursor = {
        inactive_timeout = 0;
        no_hardware_cursors = true;
        hide_on_key_press = false;
      };
      monitor = [
        ", preferred, auto, auto"
        "DP-2, preferred, auto-right, 1"
        "DP-3, preferred, auto-left, 1"
      ];
      decoration = {
        rounding = 6;
        blur = {
          size = 8;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = false;
        };
        shadow = {
          enabled = true;
          range = 8;
          color = "000000";
        };
      };
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
      bind = [
        "$mod, F, exec, firefox"
        "$mod, Q, exec, kitty"
        "$mod, R, exec, rofi -show drun"
        "$mod, M, exit"
        "$mod, J, togglesplit,"

        # moving focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # moving windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"

        # closing windows
        "$mod, mouse:274, killactive"
        "$mod, X, killactive"

        ", Print, exec, grimblast copy area"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));

      exec-once = [ "kitty & waybar" ];
    };

  };

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.05";

  home.packages = [ ];

  home.file = { };

  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
