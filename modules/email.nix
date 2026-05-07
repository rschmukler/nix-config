{ pkgs, ... }:

let
  # Pin nixpkgs-unstable for himalaya 1.2.0 which supports the notmuch
  # cargo feature. Self-contained — no changes to flake.nix required.
  # To update: pick a new rev from nixpkgs-unstable and refresh the hash with
  #   nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/<rev>.tar.gz
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/68a8af93ff4297686cb68880845e61e5e2e41d92.tar.gz";
    sha256 = "1slqf8p2178xszw0y1li79kq23kdxnyzdm9ndcrzfwv24fs350d5";
  }) { inherit (pkgs.stdenv.hostPlatform) system; };

  # himalaya with notmuch backend support.
  # The default nixpkgs build omits the notmuch cargo feature;
  # override to include it so himalaya can query a local notmuch index.
  himalaya-notmuch = unstable.himalaya.override {
    buildFeatures = [ "notmuch" ];
  };
in
{
  environment.systemPackages = [
    himalaya-notmuch
    pkgs.isync          # mbsync — IMAP-to-Maildir sync
    pkgs.notmuch        # Xapian-based email indexer / search
    pkgs.goimapnotify   # IMAP IDLE watcher — triggers sync on new mail
  ];
}
