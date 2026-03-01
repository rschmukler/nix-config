{ stdenv, fetchurl, lib }:

let
  sources = {
    "aarch64-darwin" = {
      url = "https://github.com/borkdude/cream/releases/download/dev/cream-macos-aarch64.tar.gz";
      hash = "sha256-iCfzHWM0tWm3hpy7dhqKg7CfL1vj5SiTwQPDXf97vWc=";
    };
    "x86_64-linux" = {
      url = "https://github.com/borkdude/cream/releases/download/dev/cream-linux-amd64.tar.gz";
      hash = "sha256-wbfI7CQAc418dgUKsIYFm5xqbffx/cq+lHwhvInU3mw=";
    };
  };
  source = sources.${stdenv.hostPlatform.system} or (throw "cream: unsupported platform ${stdenv.hostPlatform.system}");
in
stdenv.mkDerivation {
  pname = "cream";
  version = "dev";

  src = fetchurl { inherit (source) url hash; };

  sourceRoot = ".";

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp cream $out/bin/cream
    chmod +x $out/bin/cream
  '';

  meta = {
    description = "cream — a tool by borkdude";
    homepage = "https://github.com/borkdude/cream";
    platforms = lib.attrNames sources;
  };
}
