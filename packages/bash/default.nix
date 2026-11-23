{ ... }:

{
  flake.homeModules.bash =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      config = {
        programs = {
          bash = {
            enable = true;
            sessionVariables = {
              EDITOR = lib.mkIf (config.programs.neovim.enable && config.programs.myneovim.enable) "nvim";
            };
            initExtra = ''
              source ${pkgs.git}/share/bash-completion/completions/git-prompt.sh
              BASE_PROMPT='\[\033[0;32m\][\u@\h \W]\$\[\033[1;36m\]$(__git_ps1 " %s")\[\033[0;00m\] '
              export PS1=$BASE_PROMPT

              if [[ "$IN_NIX_SHELL" == "impure" || "$IN_NIX_SHELL" == "pure" ]]; then
                export PS1='\[\033[41m\]\[\033[1;30m\](nix-shell#$IN_NIX_SHELL)'$BASE_PROMPT
              fi
              bind '"\e[A":history-search-backward'
              bind '"\e[B":history-search-forward'
            '';
            enableCompletion = true;
            # automatically attach tmux to bash shell
            bashrcExtra = lib.mkIf config.programs.tmux.enable ''
              if [ -x "$(command -v tmux)" ] && [ -n "$WAYLAND_DISPLAY" ] && [ -z "$TMUX" ]; then
                exec tmux new-session -A -s $USER >/dev/null 2>&1
              fi
            '';
          };
        };
      };
    };
}
