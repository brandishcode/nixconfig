{ withSystem, inputs, self, ... }:

let
  tweaks = {
    text = ''
      {
        "title_series_sorting": "strictly_alphabetic"
      }
    '';
    force = true;
  };
  saveToDisk = {
    text = ''
      {
        "asciiize": false,
        "formats": "all",
        "replace_whitespace": false,
        "save_cover": true,
        "save_extra_files": true,
        "send_template": "library/{author_sort}/{title} - {authors}",
        "send_timefmt": "%b, %Y",
        "single_dir": false,
        "template": "{author_sort}/{title}/{title} - {authors}",
        "timefmt": "%b, %Y",
        "to_lowercase": false,
        "update_metadata": true,
        "write_opf": true
      }
    '';
    force = true;
  };
in
{
  perSystem = { pkgs, ... }:
  let
    noDRM_DeDRM = pkgs.fetchzip { 
      name = "noDRM-DeDRM_tools";
      url = "https://github.com/noDRM/DeDRM_tools/releases/download/v10.0.9/DeDRM_tools_10.0.9.zip";
      hash = "sha256-3gMzURkI6U7tU3CDiK4Y81xGH0YxrMIVt2dt3JRpih4=";
      stripRoot = false;
    };
    calibreInitialize = pkgs.writeShellScript "calibre-initialize" ''
      if ! ${pkgs.calibre}/bin/calibre-customize -l | grep -w DeDRM; then
        ${pkgs.calibre}/bin/calibre-customize -a ${noDRM_DeDRM}/DeDRM_plugin.zip
      fi
      
      if ! ${pkgs.calibre}/bin/calibre-customize -l | grep -w "Obok DeDRM"; then
        ${pkgs.calibre}/bin/calibre-customize -a ${noDRM_DeDRM}/Obok_plugin.zip
      fi
    '';
  in {
    packages.calibre = pkgs.symlinkJoin {
      name = "calibre";
      paths = [ pkgs.calibre ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/calibre --run ${calibreInitialize}
      '';
    };
  };

  # Per user definitions
  flake.homeModules.calibre = { system, ... }: {
    programs.calibre.enable = true;
    programs.calibre.package = self.packages.${system}.calibre;
    xdg.configFile = {
      "calibre/tweaks.json" = tweaks;
      "calibre/save_to_disk.py.json" = saveToDisk;
    };
  };
}
