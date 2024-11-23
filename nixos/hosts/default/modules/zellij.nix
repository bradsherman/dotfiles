{ pkgs, ... }:

{
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
    ".config/zellij/config.kdl".text = ''
      keybinds {
          normal clear-defaults=true {
              bind "Ctrl s" { SwitchToMode "Tmux"; }
              unbind "Ctrl b"
          }
          locked {
              bind "Ctrl g" { SwitchToMode "Normal"; }
          }
          resize {
              bind "Ctrl n" { SwitchToMode "Normal"; }
              bind "h" "Left" { Resize "Increase Left"; }
              bind "j" "Down" { Resize "Increase Down"; }
              bind "k" "Up" { Resize "Increase Up"; }
              bind "l" "Right" { Resize "Increase Right"; }
              bind "H" { Resize "Decrease Left"; }
              bind "J" { Resize "Decrease Down"; }
              bind "K" { Resize "Decrease Up"; }
              bind "L" { Resize "Decrease Right"; }
              bind "=" "+" { Resize "Increase"; }
              bind "-" { Resize "Decrease"; }
          }
          pane {
              bind "Ctrl p" { SwitchToMode "Normal"; }
              bind "h" "Left" { MoveFocus "Left"; }
              bind "l" "Right" { MoveFocus "Right"; }
              bind "j" "Down" { MoveFocus "Down"; }
              bind "k" "Up" { MoveFocus "Up"; }
              bind "p" { SwitchFocus; }
              bind "n" { NewPane; SwitchToMode "Normal"; }
              bind "d" { NewPane "Down"; SwitchToMode "Normal"; }
              bind "r" { NewPane "Right"; SwitchToMode "Normal"; }
              bind "x" { CloseFocus; SwitchToMode "Normal"; }
              bind "f" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
              bind "z" { TogglePaneFrames; SwitchToMode "Normal"; }
              bind "w" { ToggleFloatingPanes; SwitchToMode "Normal"; }
              bind "e" { TogglePaneEmbedOrFloating; SwitchToMode "Normal"; }
              bind "c" { SwitchToMode "RenamePane"; PaneNameInput 0;}
          }
          move {
              bind "Ctrl h" { SwitchToMode "Normal"; }
              bind "n" "Tab" { MovePane; }
              bind "p" { MovePaneBackwards; }
              bind "h" "Left" { MovePane "Left"; }
              bind "j" "Down" { MovePane "Down"; }
              bind "k" "Up" { MovePane "Up"; }
              bind "l" "Right" { MovePane "Right"; }
          }
          tab {
              bind "Ctrl t" { SwitchToMode "Normal"; }
              bind "r" { SwitchToMode "RenameTab"; TabNameInput 0; }
              bind "h" "Left" "Up" "k" { GoToPreviousTab; }
              bind "l" "Right" "Down" "j" { GoToNextTab; }
              bind "n" { NewTab; SwitchToMode "Normal"; }
              bind "x" { CloseTab; SwitchToMode "Normal"; }
              bind "s" { ToggleActiveSyncTab; SwitchToMode "Normal"; }
              bind "b" { BreakPane; SwitchToMode "Normal"; }
              bind "]" { BreakPaneRight; SwitchToMode "Normal"; }
              bind "[" { BreakPaneLeft; SwitchToMode "Normal"; }
              bind "1" { GoToTab 1; SwitchToMode "Normal"; }
              bind "2" { GoToTab 2; SwitchToMode "Normal"; }
              bind "3" { GoToTab 3; SwitchToMode "Normal"; }
              bind "4" { GoToTab 4; SwitchToMode "Normal"; }
              bind "5" { GoToTab 5; SwitchToMode "Normal"; }
              bind "6" { GoToTab 6; SwitchToMode "Normal"; }
              bind "7" { GoToTab 7; SwitchToMode "Normal"; }
              bind "8" { GoToTab 8; SwitchToMode "Normal"; }
              bind "9" { GoToTab 9; SwitchToMode "Normal"; }
              bind "Tab" { ToggleTab; }
          }
          scroll {
              bind "Ctrl s" { SwitchToMode "Normal"; }
              bind "e" { EditScrollback; SwitchToMode "Normal"; }
              bind "s" { SwitchToMode "EnterSearch"; SearchInput 0; }
              bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
              bind "j" "Down" { ScrollDown; }
              bind "k" "Up" { ScrollUp; }
              bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
              bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
              bind "d" { HalfPageScrollDown; }
              bind "u" { HalfPageScrollUp; }
          }
          search {
              bind "Ctrl s" { SwitchToMode "Normal"; }
              bind "Ctrl c" { ScrollToBottom; SwitchToMode "Normal"; }
              bind "j" "Down" { ScrollDown; }
              bind "k" "Up" { ScrollUp; }
              bind "Ctrl f" "PageDown" "Right" "l" { PageScrollDown; }
              bind "Ctrl b" "PageUp" "Left" "h" { PageScrollUp; }
              bind "d" { HalfPageScrollDown; }
              bind "u" { HalfPageScrollUp; }
              bind "n" { Search "down"; }
              bind "p" { Search "up"; }
              bind "c" { SearchToggleOption "CaseSensitivity"; }
              bind "w" { SearchToggleOption "Wrap"; }
              bind "o" { SearchToggleOption "WholeWord"; }
          }
          entersearch {
              bind "Ctrl c" "Esc" { SwitchToMode "Scroll"; }
              bind "Enter" { SwitchToMode "Search"; }
          }
          renametab {
              bind "Ctrl c" { SwitchToMode "Normal"; }
              bind "Esc" { UndoRenameTab; SwitchToMode "Tab"; }
          }
          renamepane {
              bind "Ctrl c" { SwitchToMode "Normal"; }
              bind "Esc" { UndoRenamePane; SwitchToMode "Pane"; }
          }
          session {
              bind "Ctrl o" { SwitchToMode "Normal"; }
              bind "Ctrl s" { SwitchToMode "Scroll"; }
              bind "d" { Detach; }
              bind "w" {
                  LaunchOrFocusPlugin "session-manager" {
                      floating true
                      move_to_focused_tab true
                  };
                  SwitchToMode "Normal"
              }
          }
          tmux {
              bind "[" { SwitchToMode "Scroll"; }
              bind "Esc" { SwitchToMode "Normal"; }
              bind "g" { SwitchToMode "Locked"; }
              bind "p" { SwitchToMode "Pane"; }
              bind "t" { SwitchToMode "Tab"; }
              bind "n" { SwitchToMode "Resize"; }
              bind "s" { SwitchToMode "Scroll"; }
              bind "o" { SwitchToMode "Session"; }
              bind "q" { Quit; }

              bind "Ctrl c" { SwitchToMode "Normal"; }
              bind "-" { NewPane "Down"; SwitchToMode "Normal"; }
              bind "|" { NewPane "Right"; SwitchToMode "Normal"; }
              bind "z" { ToggleFocusFullscreen; SwitchToMode "Normal"; }
              bind "c" { NewTab; SwitchToMode "Normal"; }
              bind "," { SwitchToMode "RenameTab"; }
              bind "Left" { MoveFocus "Left"; SwitchToMode "Normal"; }
              bind "Right" { MoveFocus "Right"; SwitchToMode "Normal"; }
              bind "Down" { MoveFocus "Down"; SwitchToMode "Normal"; }
              bind "Up" { MoveFocus "Up"; SwitchToMode "Normal"; }
              bind "h" { MoveFocus "Left"; SwitchToMode "Normal"; }
              bind "l" { MoveFocus "Right"; SwitchToMode "Normal"; }
              bind "k" { MoveFocus "Up"; SwitchToMode "Normal"; }
              bind "d" { Detach; }
              bind "Space" { NextSwapLayout; }
              bind "x" { CloseFocus; SwitchToMode "Normal"; }
          }
          shared_except "locked" {
              bind "Ctrl g" { SwitchToMode "Locked"; }
              bind "Ctrl q" { Quit; }
              bind "Alt n" { NewPane; }
              bind "Alt i" { MoveTab "Left"; }
              bind "Alt o" { MoveTab "Right"; }
              bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
              bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
              bind "Alt j" "Alt Down" { MoveFocus "Down"; }
              bind "Alt k" "Alt Up" { MoveFocus "Up"; }
              bind "Alt =" "Alt +" { Resize "Increase"; }
              bind "Alt -" { Resize "Decrease"; }
              bind "Alt [" { PreviousSwapLayout; }
              bind "Alt ]" { NextSwapLayout; }
          }
          shared_except "normal" "locked" {
              bind "Enter" "Esc" { SwitchToMode "Normal"; }
          }
          shared_except "tmux" "locked" {
              bind "Ctrl s" { SwitchToMode "Tmux"; }
          }
      }

      plugins {
          tab-bar location="zellij:tab-bar"
          status-bar location="zellij:status-bar"
          strider location="zellij:strider"
          compact-bar location="zellij:compact-bar"
          session-manager location="zellij:session-manager"
          welcome-screen location="zellij:session-manager" {
              welcome_screen true
          }
          filepicker location="zellij:strider" {
              cwd "/"
          }
      }

      pane_frames false

      themes {
          kanagawa-wave {
              fg "#dcd7ba"
              bg "#1f1f28"
              red "#c34043"
              green "#76946a"
              yellow "#c0a36e"
              blue "#7e9cd8"
              magenta "#957fb8"
              cyan "#6a9589"
              orange "#ffa066"
              black "#090618"
              white "#c8c093"
          }
          kanagawa-dragon {
              fg "#c5c9c5"
              bg "#181616"
              red "#c4746e"
              green "#8a9a7b"
              yellow "#c4b28a"
              blue "#8ba4b0"
              magenta "#a292a3"
              cyan "#8ea4a2"
              orange "#b6927b"
              black "#0d0c0c"
              white "#c5c9c5"
          }
      }
      theme "kanagawa-dragon"

      default_layout "compact"

      copy_command "wl-copy"
    '';
    ".config/zellij/layouts/default.kdl".text = ''
      layout {
          default_tab_template {
              children
              pane size=1 borderless=true {
                  plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
                      format_left  "#[fg=#658594]{session} {mode} {tabs}"
                      format_space ""

                      hide_frame_for_single_pane "true"

                      mode_normal  "#[fg=#C8C093] {name} "
                      mode_locked  "#[fg=#E46876] {name} "

                      tab_normal   "#[fg=#727169] {name} "
                      tab_active   "#[fg=#76946A] {name} "
                  }
              }
          }
      }
    '';
  };
}
