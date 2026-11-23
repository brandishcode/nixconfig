{ ... }:

{
  flake.homeModules.tmux = { pkgs, ... }: {
    programs = {
      tmux = {
        enable = true;
        terminal = "tmux-256color";
        keyMode = "vi";
        extraConfig = ''
          set -s copy-command 'wl-copy'
        '';
        plugins = with pkgs; [
          { plugin = tmuxPlugins.resurrect; }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
            '';
          }
        ];
      };
    };
  };
}
