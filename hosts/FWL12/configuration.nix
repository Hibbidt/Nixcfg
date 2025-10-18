# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ./networking.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "FWL12"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "de";
  #   useXkbConfig = true; # use xkb.options in tty.
   };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

# Added for Driver and Firmware updates
services.fwupd = {
    enable = true;
extraRemotes = ["lvfs-testing"];
# May be necessary to make the update succed once
uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;
};

# Added for swaylock to work

security.pam.services.hyprlock = {};

    # btrfs autoscrub
    services.btrfs.autoScrub = {
        enable = true;
        interval = "monthly";
        fileSystems = [ "/"];
        };

    # Should add Hibernate
    powerManagement = {
        enable = true;
    };
    #Setting Hibernation settings and Power Button settings
    services.power-profiles-daemon.enable = true;
    # Suspend first then hibernate when closing the lid
    services.logind.lidSwitch = "suspend";#-then-hibernate";
    # Hibernate on power button pressed
    services.logind.powerKey = "suspend";#hibernate";
    services.logind.powerKeyLongPress = "poweroff";


  # Configure keymap in X11
  services.xserver.xkb = {
  	layout = "de";
  	variant = "";
	};
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.

  # services.pulseaudio = {
  #     enable = true;
  # };

  # OR
   services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
   };

#Enable bluetooth

hardware.bluetooth = {
    enable = true;
    settings = {
        General = {
            Experimental = true; # Shows batter charge of connected deivces if supported
            };
        };
        };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput = {
       enable = true;

       };

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [ # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     neovim 
     wget
     git 
     curl
     fish
     iio-sensor-proxy
     iio-hyprland
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh= {
   enable = true;
   settings.PermitRootLogin = "no";
   allowSFTP = true;
   };

   programs.thunar = {
       enable = true;
       };

   programs.hyprland = {
   enable = true;
   xwayland.enable = true;
   };

   programs.fish = {
   enable = true;
   };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
