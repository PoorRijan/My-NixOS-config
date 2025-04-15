# To update the system use
# This updates the lock file
nix flake update

# Now do
sudo nixos-rebuild switch --flake .#nixos # assumes your hostname is nixos
