{ config, lib, ... }:

{
  config = {
    sops.templates."gitconfig-extra".content = ''
      [user]
        name = ${config.sops.placeholder."git/name"}
        email = ${config.sops.placeholder."git/email"}
    '';
    programs = {
      git = {
        enable = true;
        settings = {
          init.defaultBranch = "main";
        };
        includes = [
          {
            path = config.sops.templates."gitconfig-extra".path;
          }
        ];
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
