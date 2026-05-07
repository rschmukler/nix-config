{ pkgs, ... }:
{
  # Lorri is incompatible with Lix due to build hook protocol differences,
  # causing "unexpected EOF reading a line" errors. Use direnv + nix-direnv instead,
  # which is the modern recommended alternative and works correctly with Lix.
  environment.systemPackages = [
    pkgs.direnv
    pkgs.nix-direnv
  ];

  # Make direnv source nix-direnv's direnvrc globally so `use flake` is
  # overridden with the cached version (skips nix evaluation on entry when
  # nothing has changed).
  environment.etc."direnv/direnvrc".text = ''
    source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
  '';

  # Hook direnv into the shell for all users.
  programs.zsh.interactiveShellInit = ''
    eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
  '';

  programs.bash.interactiveShellInit = ''
    eval "$(${pkgs.direnv}/bin/direnv hook bash)"
  '';

  # Keep build outputs and derivations so nix-direnv can reuse them.
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
}
