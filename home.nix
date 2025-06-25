{ config, pkgs, ... }:

{
  # shell
  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        cd = "z";
        "cd.." = "z ..";
        ".." = "z ..";
        g = "git";
        ll = "ls -l";
        rebuild = "sudo nixos-rebuild switch --flake ~/dot";
        update = "nix flake update";
      };
      settings = {
        show_banner = false;
        completions.external = {
          enable = true;
          max_results = 200;
        };
      };
      extraConfig = ''
        clear
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
  };

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  home.stateVersion = "25.05";

  home.packages = [ ];

  home.file = { };

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
