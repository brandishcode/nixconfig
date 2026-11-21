{ self, ... }:

{
  perSystem = { pkgs, ... }: {
    packages.ranger = pkgs.ranger.overrideAttrs (old: {
      postPatch = old.postPatch + ''
        sed -i '/pdf)/,/exit 1;;/ s/^\([[:space:]]*\)/\1#/' ranger/data/scope.sh
        sed -i '/# video\/\*)/,/exit 1;;/ s/\([[:space:]]*\)# /\1/' ranger/data/scope.sh
        sed -i '/# application\/pdf)/,/&& exit 6 || exit 1;;/ s/\([[:space:]]*\)## /\1/' ranger/data/scope.sh
      '';
    });
  };

  flake.homeModules.ranger = { pkgs, system, ... }: {
    programs.ranger = {
      enable = true;
      package = self.packages.${system}.ranger;
      extraConfig = ''
        set preview_images_method sixel
        set use_preview_script true
      '';
      extraPackages = with pkgs; [
        ffmpegthumbnailer
        poppler-utils
      ];
    };
  };
}
