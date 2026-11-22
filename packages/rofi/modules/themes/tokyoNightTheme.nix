{ ... }:

{
  perSystem = { pkgs, ... }: {
    packages.rofi-theme-tokyo-night = pkgs.stdenvNoCC.mkDerivation {
      pname = "rofi-theme-tokyo-night";
      version = "1.0";
      dontBuild = true;
      src = pkgs.fetchFromGitHub {
        owner = "brandishcode";
        repo = "Tokyonight-rofi-theme";
        rev = "e87df5c684c94015da7d7a3bd0d8e983bce5ae66";
        sha256 = "sha256-14lT1GRM1MtuZfIVP+gPWFfk5VXbXfKFYcpqS1yY++E=";
      };

      installPhase = ''
        mkdir -p $out/share/rofi/themes
        cp -aR $src $out/share/rofi/themes/tokyo-night
      '';
    };
  };
}
