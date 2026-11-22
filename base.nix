{ pkgs, ... }:
{
  imports = [
    ./modules/direnv.nix
    ./modules/email.nix
  ];

  # Make nix binaries available when using sudo (sudo strips PATH by default).
  # Without this, `sudo darwin-rebuild` and `sudo nix` fail to resolve.
  security.sudo.extraConfig = ''
    Defaults secure_path = "/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
  '';

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
