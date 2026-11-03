{ config, lib, ... }:

{
  config = {
    programs = {
      git = {
        enable = true;
        settings = {
          user = {
            name = config.git.username;
            email = config.git.useremail;
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
