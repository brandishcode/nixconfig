{ config, lib, ... }:

{
  config = {
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            name = "brandishcode";
            email = "brandishcode@gmail.com";
          };
          init.defaultBranch = "main";
        };
      };
      gh = {
        enable = true;
      };
      bash = {
        initExtra = lib.mkMerge [
          # "export GITHUB_TOKEN=$(cat ${config.sops.secrets.git_token.path})"
        ];
      };
    };
  };
}
