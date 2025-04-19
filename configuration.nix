# configuration.nix (or hosts/nixos/configuration.nix)

{ config, pkgs, lib, ... }: # Ensure lib is available if needed by imported modules

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix # Or ./hosts/nixos/hardware-configuration.nix if using that structure
      # Import your new modules
      ./modules/nixos/dns.nix
      ./modules/nixos/postgres.nix
      ./modules/nixos/printing.nix
      ./modules/nixos/audio.nix

      # Keep your custom package imports (consider moving to overlays later)
      ./personal/plink2.nix
      ./personal/snpeff.nix

      # Import home-manager config (unless handled directly in flake.nix)
      # ./modules/home-manager/rijan.nix # Keep this if not using the flake.nix HM setup
    ];

  # --- Remaining Configuration ---

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  # ... keep other i18n settings ...

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Keybase/KBFS settings
  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.kbfs.mountPoint = "/home/rijan/keybase/";

  # Nix Flakes settings
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # User account definition
  users.users.rijan = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel"]; # Keep existing groups
    shell = pkgs.fish; # Define shell here
    useDefaultShell = true; # This might be redundant if shell is set, but ok
  };

  # Home Manager setup (remove if handled directly in flake.nix as recommended previously)
  # If you keep it here, ensure the path is correct
  home-manager.users.rijan = import ./modules/home-manager/rijan.nix;

  # Fish shell program enable (might be better in home-manager)
  programs.fish.enable = true;

  # System packages (keep this minimal, user packages belong in home-manager)
  environment.systemPackages = with pkgs; [
    # Add essential system-wide tools if any, e.g., wget, curl, git?
  ];

  # --- System Auto Upgrade (Corrected Placement) ---
  system.autoUpgrade.enable = true; # Place it here
  system.autoUpgrade.allowReboot = true; # Place it here

  # System state version - VERY IMPORTANT
  system.stateVersion = "24.11"; # Or your actual state version
}
