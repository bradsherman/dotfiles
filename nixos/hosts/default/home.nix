{ config, pkgs, lib, inputs, ... }:

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
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

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
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" "Hasklig" "Iosevka" "IosevkaTerm" "SourceCodePro" ]; })
    pkgs.zoxide
    pkgs.gnupg
    pkgs.keychain
    pkgs.lsd
    pkgs.bat
    pkgs.tldr
    pkgs.libnotify
    pkgs.zellij

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
    pkgs.zig
    pkgs.shellcheck

    pkgs.spotify
    pkgs.slack

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

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      modifier = "Mod4";
      terminal = "wezterm";
      fonts = {
        names = [ "SauceCodePro Nerd Font Mono" ];
        size = 13.0;
      };
      gaps = {
        top = 10;
        left = 10;
        bottom = 10;
        right = 10;
        inner = 5;
      };
      bars = [];
# set $ws1 "1:term"
# set $ws2 "2:web"
# set $ws3 "3:slack"
# set $ws4 "4:spotify"
      defaultWorkspace = "workspace number 1";
      assigns = {
        "1" = [{ class = "^Wezterm$"; }];
        "2" = [{ class = "^Firefox$"; }];
      };

      startup = [
        { command = "firefox"; }
        { command = "wezterm"; }
        { command = "waybar"; }
        # { command = "systemctl --user restart waybar"; always = true; }
        { command = "systemctl --user restart mako"; always = true; }
        { command = "systemctl --user restart swayidle"; always = true; }
      ];
    };
    # extraConfig = builtins.readFile "./sway.config";
    extraConfig = ''
      default_border pixel 2
      input 'type:keyboard' {
          xkb_layout us,es,de
          xkb_options caps:ctrl_modifier
      }

      input 'type:touchpad' {
        natural_scroll enabled
      }

      set $mod Mod4
      unbindsym $mod+space
      bindsym $mod+space exec wofi --show run
      bindsym $mod+Shift+r reload
      # bindsym $mod+Shift+c restart
      include ~/.config/sway/kanagawa

      # exec_always killall swaybg
      exec_always swaybg -o "*" -i "/home/bsherman/Pictures/leaves.jpg" -m fill

      bindsym Print exec grim -g "$(slurp)" - | wl-copy
      bindsym Shift+Print exec ~/.config/sway/bin/screenshot.sh
      bindsym $mod+Escape exec makoctl dismiss -a

      bindsym $mod+Shift+b exec ~/.local/bin/wofi-bluetooth
    '';
  };

  programs.waybar = {
    enable = true;
  };
  programs.wofi = {
    enable = true;
    settings = {
      location = "bottom-right";
      allow_markup = true;
      width = 500;
    };
    style = ''
/*
* wofi style. Colors are from authors below.
* Kanagawa Dragon theme
* Author: Brad Sherman (sherman.brad@proton.me), rebelot (https://github.com/rebelot/kanagawa.nvim)
*
*/
@define-color background #2d4f67;
@define-color foreground #c8c093;
@define-color red #c4746e;
@define-color base09 #b6927b;
@define-color yellow #c4b28a;
@define-color teal #7aa89f;
@define-color green #8a9a7b;
@define-color blue #8ba4b0;
@define-color purple #a292a3;
@define-color base0F #b98d7b;
window {
    opacity: 0.9;
    border:  0px;
    border-radius: 10px;
    font-family: monospace;
    font-size: 18px;
}

#input {
	border-radius: 10px 10px 0px 0px;
    border:  0px;
    padding: 10px;
    margin: 0px;
    font-size: 28px;
	color: @green;
	background-color: @background;
}

#inner-box {
	margin: 0px;
	color: @foreground;
	background-color: @background;
}

#outer-box {
	margin: 0px;
	background-color: @background;
    border-radius: 10px;
}

#selected {
	background-color: @purple;
}

#entry {
	padding: 0px;
    margin: 0px;
	background-color: @background;
}

#scroll {
	margin: 5px;
	background-color: @background;
}

#text {
	margin: 0px;
	padding: 2px 2px 2px 10px;
}
    '';
  };
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    timeouts = [
      {
        timeout = 270;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds' -t 10000";
      }
      {
        timeout = 280;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 20 seconds' -t 10000";
      }
      {
        timeout = 290;
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 10 seconds' -t 10000";
      }
      {
        timeout = 300;
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
      }
      {
        timeout = 605;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock";
      }
    ];
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    package = inputs.wezterm.packages.x86_64-linux.default;
    extraConfig = ''
local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Kanagawa (Gogh)"
config.force_reverse_video_cursor = true
config.colors = {
	-- Kanagaway Wave
	foreground = "#dcd7ba",
	background = "#1f1f28",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },

	-- Kanagawa Dragon
	-- foreground = "#c5c9c5",
	-- background = "#181616",
	--
	-- cursor_bg = "#c8c093",
	-- cursor_fg = "#c8c093",
	-- cursor_border = "#c8c093",
	--
	-- selection_fg = "#c8c093",
	-- selection_bg = "#2d4f67",
	--
	-- scrollbar_thumb = "#16161d",
	-- split = "#16161d",
	--
	-- ansi = { "#0d0c0c", "#c4746e", "#8a9a7b", "#c4b28a", "#8ba4b0", "#a292a3", "#8ea4a2", "#C8C093" },
	-- brights = { "#a6a69c", "#E46876", "#87a987", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#c5c9c5" },
	-- indexed = { [16] = "#b6927b", [17] = "#b98d7b" },
}
config.font = wezterm.font("Iosevka Nerd Font")
-- config.font = wezterm.font("Victor Mono")
-- config.font = wezterm.font("Rec Mono Duotone")
config.term = "wezterm"
config.window_background_opacity = 0.85
config.text_background_opacity = 0.85
config.enable_tab_bar = false
-- config.default_prog = { "zellij", "-l", "welcome" }
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

return config
    '';
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
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
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
