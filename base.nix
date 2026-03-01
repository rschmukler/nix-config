{ pkgs, ... }:
{
  imports = [ ./modules/direnv.nix ];

  # Common packages used across all systems
  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.local.cream
  ];
}
