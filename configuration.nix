# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./hardware-configuration.nix
      ./nvidia.nix
      ./system.nix
      ./network.nix
      ./home.nix
    ];


#   imports = [
#     <home-manager/nixos>
#     ];

#   nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  hardware.enableRedistributableFirmware = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_lts;
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.blacklistedKernelModules = [ "nouveau" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jerusalem";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IL";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "he_IL.UTF-8";
    LC_IDENTIFICATION = "he_IL.UTF-8";
    LC_MEASUREMENT = "he_IL.UTF-8";
    LC_MONETARY = "he_IL.UTF-8";
    LC_NAME = "he_IL.UTF-8";
    LC_NUMERIC = "he_IL.UTF-8";
    LC_PAPER = "he_IL.UTF-8";
    LC_TELEPHONE = "he_IL.UTF-8";
    LC_TIME = "he_IL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
#   services.xserver.enable = true;


#   services.xserver = {
#     enable = true;
#     layout = "us,il";       # English + Hebrew
#     xkbOptions = "grp:alt_shift_toggle";  # Alt+Shift to switch
#   };


  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

#   # Configure keymap in X11
#   services.xserver.xkb = {
#     layout = "us";
#     variant = "";
#   };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yoav = {
    isNormalUser = true;
    description = "Yoav Ben-Yosef";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  # programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    iso-flags
    vivaldi
    vivaldi-ffmpeg-codecs
    gparted
    expressvpn
    insync
    git
    wine
    mono
    input-remapper
    steam
  ];

#    programs.steam.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?


#   #=====================================================
#   #                     ExpressVPN
#   # expressvpn activation - doesn't seem to work
#   systemd.services.expressvpnActivate = {
#     description = "ExpressVPN non-interactive activation";
#     after = [ "network-online.target" ];
#     wantedBy = [ "multi-user.target" ];
#     serviceConfig = {
#       ExecStart = "${pkgs.expressvpn}/bin/expressvpn activate < /etc/exvpn-activation-code";
#       StandardInput = "tty";
#     };
#   };
#   environment.etc."exvpn-activation-code".text = "ECUWXN2XTZLRNWMESY3JXJI";
#   #=====================================================


#   #=====================================================
#   #                       Steam
#   {
#     # Enable 32-bit support (required for Steam)
#     hardware.opengl.driSupport32Bit = true;
#
#     # Enable Steam
#     programs.steam = {
#       enable = true;
#       remotePlay.openFirewall = true; # Optional: Open ports in the firewall for Steam Remote Play
#       dedicatedServer.openFirewall = true; # Optional: Open ports in the firewall for Source Dedicated Server
#     };
#   }
#   #=====================================================


  #=====================================================
  #                     Home Manager
  home-manager.users.yoav = {   # <-- replace with your username
    home.stateVersion = "25.05"; # match your NixOS release
    programs.bash.enable = true;
    programs.git = {
      enable = true;
      userName = "Yoav Ben-Yosef";
      userEmail = "yoav.benyosef@gmail.com";
    };
  };
  #=====================================================

}
