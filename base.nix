{ pkgs, ... }:
{
  imports = [ ./modules/direnv.nix ];

  # Common packages used across all systems
  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.nix-search-cli
    pkgs.local.cream
    pkgs.uv
    pkgs.himalaya
    pkgs.tmux
    pkgs.difftastic
    pkgs.zoxide
  ];
}
