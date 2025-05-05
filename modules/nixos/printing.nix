# modules/nixos/printing.nix
{ config, pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ]; # Keep or expand this list

    # --- Replace these lines ---
    # Browse = true;
    # browsedConf = ''
    #   BrowseDNSSDSubTypes _cups,_print
    #   BrowseLocalProtocols all
    #   BrowseRemoteProtocols all
    #   CreateIPPPrinterQueues All
    #   BrowseProtocols all
    # '';
    # --- With these ---
    discovery = {
      enable = true; # Explicitly enable modern discovery using Avahi/DNS-SD
      # This mimics your 'CreateIPPPrinterQueues All' setting.
      # Alternatives: "Local" (only create for printers on localhost), "Manual" (don't auto-create)
      createIPPPrinterQueues = "All";
    };
    # --- End Replacement ---
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # Good, handles Avahi firewall rules if firewall is enabled
  };

  # Optional: Explicitly set admin group if not default 'wheel'
  # services.printing.adminUserGroup = "lpadmin";

  # Optional: Ensure CUPS port is open if using NixOS firewall elsewhere
  # networking.firewall.allowedTCPPorts = [ 631 ]; # For web UI access from network / printer sharing
}
