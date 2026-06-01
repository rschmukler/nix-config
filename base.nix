{ pkgs, ... }:
{
  imports = [
    ./modules/direnv.nix
    ./modules/email.nix
  ];

  # Common packages used across all systems
  environment.systemPackages = [
    pkgs.nixfmt
    pkgs.nix-search-cli
    pkgs.local.cream
    pkgs.uv
    pkgs.tmux
    pkgs.socat
    pkgs.difftastic
    pkgs.zoxide
  ];
}
