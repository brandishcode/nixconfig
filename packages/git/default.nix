{ ... }:

{
  flake.homeModules.git =
    { config, ... }:
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
        };
      };
    };
}
