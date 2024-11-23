{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      vim = "nvim";
      vv = "pushd ~/.config/nvim; vim .; popd;";
      vz = "vim ~/.zshrc";
      sz = "source ~/.zshrc";
      cat = "bat --theme=$BAT_THEME";
      c = "clear";
      zj = "zellij";

      sqlite = "rlwrap -a -c -i sqlite3";
      sqlite3 = "rlwrap -a -c -i sqlite3";
      htop = "btm";
      man = "tldr";
      shake = "stack exec shake --";
      ls = "eza";
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      edit = "sudo -e";
      update = "sudo nixos-rebuild switch --flake";
    };

    history = {
      size = 5000;
      save = 5000;
      share = true;
      append = true;
      ignoreAllDups = true;
      ignoreDups = true;
      path = "$HOME/.zsh_history";
    };
    initExtra = ''
      bindkey '^H' backward-kill-word
      bindkey -v
      bindkey "^P" up-line-or-search
      bindkey "^N" down-line-or-search
      bindkey -M viins 'jk' vi-cmd-mode
      keychain $HOME/.ssh/id_ed25519
      [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then
          . $HOME/.nix-profile/etc/profile.d/nix.sh
          export LOCALE_ARCHIVE="/usr/lib/locale/locale-archive"
          export TERMINFO=$HOME/.nix-profile/share/terminfo
      fi
      [[ ! -r /home/bsherman/.opam/opam-init/init.zsh ]] || source /home/bsherman/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
      function author_lines () {
        if [ -z "$1" ]
        then
          pattern="."
        else
          pattern="$1"
        fi
        git ls-files "$\{pattern}" | while read f
        do
          git blame --line-porcelain $f | grep '^author '
        done | sort -f | uniq -ic | sort -n
      }
      # complete -o nospace -C /nix/store/34m359hc8r2r8h9rsavysjmvyk29m0m6-nomad-1.4.4/bin/nomad nomad
      [ -f "/home/bsherman/.ghcup/env" ] && . "/home/bsherman/.ghcup/env" # ghcup-env

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      [ -s "/home/bsherman/.bun/_bun" ] && source "/home/bsherman/.bun/_bun"
      if [ -e /home/bsherman/.nix-profile/etc/profile.d/nix.sh ]; then . /home/bsherman/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
      eval "$(zoxide init --cmd cd zsh)"

      eval "$(direnv hook zsh)"
    '';
    localVariables = {
      PROMPT =
        "%F{33}b%f%F{39}s%f%F{38}h%f%F{44}erman%f%F{50}@%f%F{43}nix%f%F{44}os%f%F{38}:%1~/%f %F{44}%#%f ";
    };
    sessionVariables = {
      BAT_THEME = "kanagawa";
      EDITOR = "nvim";
      BUN_INSTALL = "$HOME/.bun";
      FLYCTL_INSTALL = "$HOME/.fly";
      PATH =
        "$HOME/nvim/bin:$HOME/.local/bin/:/opt/julia/bin:$HOME/.tfenv/bin:$HOME/.pkenv/bin:$HOME/code/lua-language-server/bin:$BUN_INSTALL/bin:$FLYCTL_INSTALL/bin:$PATH";
      VAULT_ADDR = "http://127.0.0.1:8200";
      NVM_DIR = "$HOME/.nvm";
    };
  };
}
