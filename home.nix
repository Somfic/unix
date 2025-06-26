{ config, pkgs, ... }:

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
        "rebuild" = "sudo nixos-rebuild switch --flake ~/dot"; # todo: add nom support?
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
  };

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [ "$mod, F, exec, firefox" ", Print, exec, grimblast copy area" ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (i:
          let ws = i + 1;
          in [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]) 9));
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
