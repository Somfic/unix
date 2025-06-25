{ config, pkgs, ... }:

{
  # shell
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        cd = "z";
        g = "git";
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake ~/dot";
        update = "nix flake update";
      };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.05";

  home.packages = [ ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
