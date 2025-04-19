# configuration.nix (or hosts/nixos/configuration.nix)

{ config, pkgs, lib, ... }: # Ensure lib is available if needed

{
  imports =
    [
      ./hardware-configuration.nix

      # --- Core System Modules ---
      ./modules/nixos/locale.nix     # Moved (includes timezone & i18n)
      ./modules/nixos/networking.nix # Moved (includes hostname & networkmanager)
      ./modules/nixos/bootloader.nix
      # --- Services & Hardware ---
      ./modules/nixos/audio.nix
      ./modules/nixos/DNS.nix
      ./modules/nixos/kbfs.nix       # Moved
      ./modules/nixos/postgres.nix
      ./modules/nixos/printing.nix
      ./modules/nixos/xserver.nix    # Moved (includes xorg, gdm, gnome)

      # --- Custom Packages (Consider Overlays) ---
      ./personal/plink2.nix
      ./personal/snpeff.nix

      # --- Home Manager (if not handled in flake.nix) ---
      # ./modules/home-manager/rijan.nix
    ];

  # --- Remaining Configuration ---
  # (Should be getting smaller!)

  # Nix Flakes settings
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # User account definition (Could be moved to users.nix module later)
  users.users.rijan = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel"]; # networkmanager group added by default if using networking.networkmanager module
    shell = pkgs.fish;
    useDefaultShell = true;
  };

  # Home Manager setup (if not handled in flake.nix)
  home-manager.users.rijan = import ./modules/home-manager/rijan.nix;

  # Fish shell program enable (might be better in home-manager)
  programs.fish.enable = true;

  # System packages (keep minimal)
  environment.systemPackages = with pkgs; [
    # vim
    # wget
  ];

  # System Auto Upgrade (Corrected Placement)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  # System state version - VERY IMPORTANT
  system.stateVersion = "24.11"; # Or your actual state version

  # --- REMOVED SECTIONS ---
  # All sections corresponding to the new modules created above should be gone from here.
}
