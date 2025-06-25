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
        "rebuild" = "sudo nixos-rebuild switch - -flake ~/dot";
        "update" = "nix flake update --flake ~/dot";
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
        fastfetch
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

  wayland.windowManager.hyprland.enable = true;

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.05";

  home.packages = [ ];

  home.file = { };

  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;
}
