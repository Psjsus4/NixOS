# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  pwndbg,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };

    grub = {
      enable = true;

      efiSupport = true;
      devices = ["nodev"];

      extraEntries = ''
        menuentry "Windows 11" {
          search --fs-uuid --no-floppy --set=root BE7F-92F6
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };

  #services.fprintd.enable = true;

  #security.pam.services.swaylock = {};
  #security.pam.services.swaylock.fprintAuth = false;

  nixpkgs = {
    # You can add overlays here
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable
      inputs.nix-your-shell.overlays.default
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--print-build-logs"
    ];
    dates = "06:00";
    randomizedDelaySec = "45min";
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      warn-dirty = false;
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than +5";
    };
    optimise.automatic = true;
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  networking.hostName = "psjsus4"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Rome";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "it_IT.UTF-8";
    LC_IDENTIFICATION = "it_IT.UTF-8";
    LC_MEASUREMENT = "it_IT.UTF-8";
    LC_MONETARY = "it_IT.UTF-8";
    LC_NAME = "it_IT.UTF-8";
    LC_NUMERIC = "it_IT.UTF-8";
    LC_PAPER = "it_IT.UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8";
    LC_TIME = "it_IT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg = {
    portal = {
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "it";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "it2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.

  hardware = {
    graphics.enable = true;
  };
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.darktar = {
      isNormalUser = true;
      description = "DarkTar";
      extraGroups = ["networkmanager" "wheel" "wireshark" "docker"];
      packages = [
        inputs.home-manager.packages.${pkgs.system}.default
      ];
    };
    defaultUserShell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      pwndbg = pwndbg;
    };
    useUserPackages = true;
    useGlobalPkgs = true;
    users.darktar = {
      imports = [
        #inputs.stylix.homeManagerModules.stylix
        ../home-manager/home.nix
      ];
    };
  };

  # Install firefox.
  #programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nh
    nix-output-monitor
    nixpkgs-review
    nvd
    neovim
    git
    binutils
    ltrace
    tk
    firefox
    (discord.override {
      withVencord = true;
    })
    ghidra
    ida-free
    burpsuite
    wireshark
    (
      waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
      })
    )
    kitty
    zed-editor
    vscode
    obsidian
    nixd
    zsh
    nix-your-shell
    nix-ld
    alejandra
    dunst
    swww
    wofi
    #rofi-wayland
    #  wget
  ];

  environment.sessionVariables = {
    FLAKE = "/home/darktar/.config/nixos/";
  };

  # Stylix
  stylix = {
    enable = true;
    image = ./dark-nature-sunset.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyodark.yaml";
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
    };
    fonts = {
      emoji = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code NF";
      };
      sizes = {
        terminal = 13;
        applications = 11;
      };
    };
    polarity = "dark";
    opacity = {
      desktop = 0.9;
      terminal = 0.9;
      popups = 0.9;
    };
  };

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.wireshark.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # Enable VMware Tools
  #virtualisation.vmware.guest.enable = true;
  #services.xserver.videoDrivers = ["vmware"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
