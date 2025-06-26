{ config, pkgs, inputs, lib, ... }:

{
  imports =
    [ ./hardware-configuration.nix inputs.home-manager.nixosModules.default ];

  # system packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    nixfmt
    nix-output-monitor
  ];

  # user accounts
  users.users.lucas = {
    isNormalUser = true;
    description = "lucas";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.nushell;
  };

  # homemanager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users.lucas = import ./home.nix;
  };

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # hostname  
  networking.hostName = "nixos";

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    # withUWSM = true;
    xwayland.enable = true;
  };
  services.displayManager.gdm.enable = true;

  # networking 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  networking.networkmanager.enable = true;

  # locale
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # desktop environment
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # services.xserver.libinput.enable = true; # mouse and touchpad support (enabled by default in most desktopManager)

  # printing
  services.printing.enable = true;

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];

  # sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # general nixos settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };

}
