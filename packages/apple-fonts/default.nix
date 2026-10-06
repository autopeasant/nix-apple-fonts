{ lib, stdenvNoCC, mkfontdir, mkfontscale }:
stdenvNoCC.mkDerivation {
  pname = "apple-fonts";
  version = "1.1";

  dontBuild = true;
  dontUnpack = true;
  src = ./.;

  nativeBuildInputs = [ mkfontscale mkfontdir ];

  # read install --help to find -Dm644 meaning
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/opentype
    find "$src/fonts" -name '*.otf' -exec install -Dm644 -t "$out/share/fonts/opentype" {} +
    find "$src/fonts" -name '*.ttf' -exec install -Dm644 -t "$out/share/fonts/truetype" {} +
    mkfontdir "$out/share/fonts/opentype"
    mkfontdir "$out/share/fonts/truetype"
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://developer.apple.com/fonts/";
    description = "Apple Fonts package for nixOS";
    longDescription = ''
      Get the typefaces you need to design interfaces for your apps on Apple platforms.
      These typefaces are designed to optimally display text at a variety of sizes
      and in a wide range of languages across multiple interfaces.
    '';
    platforms = platforms.all;
  };
}
