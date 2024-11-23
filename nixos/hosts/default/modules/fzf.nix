{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      fg = "#c5c9c5";
      "fg+" = "#c8c093";
      bg = "-1";
      "bg+" = "#2d4f67";
      hl = "#5f87af";
      "hl+" = "#5fd7ff";
      info = "#afaf87";
      marker = "#8a9a7b";
      prompt = "#c4746e";
      spinner = "#a292a3";
      pointer = "#938AA9";
      header = "#8ea4a2";
      border = "#0d0c0c";
      label = "#aeaeae";
      query = "#d9d9d9";
    };
    defaultCommand = "fd --type f";
    # defaultCommand = "rg --files";
    defaultOptions = [
      "-m"
      "--height 50%"
      "--layout=reverse"
      "--border='rounded'"
      "--border-label='fzf'"
      "--border-label-pos='0'"
      "--preview-window='border-rounded'"
      "--padding='1'"
      "--prompt='> '"
      "--marker='✗ '"
      "--pointer='◆ '"
      "--scrollbar='│'"
      ''
        --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} |
                cat {})) || ([[ -d {} ]] && (tree -C {} | less)) ||
                echo {} 2> /dev/null | head -200'
      ''
      "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
      "--bind '?:toggle-preview'"
    ];
  };
}
