{ pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bsherman";
  home.homeDirectory = "/home/bsherman";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # tools
    pkgs.git
    pkgs.gh
    pkgs.libgit2
    pkgs.ripgrep
    pkgs.fd
    pkgs.rsync
    pkgs.fzf
    pkgs.gnumake
    pkgs.unzip
    (pkgs.nerdfonts.override {
      fonts =
        [ "FiraCode" "Hack" "Hasklig" "Iosevka" "IosevkaTerm" "SourceCodePro" ];
    })
    pkgs.zoxide
    pkgs.gnupg
    pkgs.keychain
    pkgs.lsd
    pkgs.eza
    pkgs.bat
    pkgs.tldr
    pkgs.libnotify
    pkgs.zellij
    pkgs.nil
    pkgs.flyctl
    pkgs.jq
    pkgs.jujutsu
    # pkgs.gg
    pkgs.stylua
    pkgs.lazygit
    pkgs.tree

    # langs
    pkgs.libgcc
    pkgs.gcc
    pkgs.go
    pkgs.rustup
    pkgs.nodejs_22
    pkgs.lua
    pkgs.lua-language-server
    pkgs.selene
    pkgs.elixir
    # pkgs.haskell.compiler.ghc98 # .withPackages (hp: with hp; [ zlib ])
    # pkgs.haskell.packages.ghc98.haskell-language-server
    pkgs.haskellPackages.fourmolu
    # pkgs.haskellPackages.ghcup
    pkgs.stack
    pkgs.cabal-install
    pkgs.zig
    pkgs.shellcheck
    pkgs.haskellPackages.nixfmt

    pkgs.spotify
    pkgs.slack
    pkgs.zoom-us

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  imports = [
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/mako.nix
    ./modules/nvim.nix
    ./modules/swayidle.nix
    ./modules/wezterm.nix
    ./modules/wofi.nix
    ./modules/zellij.nix
    ./modules/zsh.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = null;
    extraConfig = builtins.readFile ./sway.config;
  };

  programs.waybar = { enable = true; };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bsherman/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
