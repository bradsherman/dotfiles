{ ... }:

{
  programs.git = {
    enable = true;
    userName = "bradsherman";
    userEmail = "bsherman1096@gmail.com";
    aliases = {
      fixup =
        "!REV=$(git log --oneline origin/master..HEAD | fzf --prompt 'fixup> ' | awk '{print $1}') && git commit --fixup $REV && EDITOR=true git rebase -i --autosquash --autostash $REV^";
      st = "status";
      co = "checkout";
      ci = "commit";
      rb = "rebase";
      br = "branch";
      pom = "pull origin master";
      rom = "pull --rebase origin master";
      df = "difftool";
      dft = "difftool";
      dlog =
        "!f() { : git log ; GIT_EXTERNAL_DIFF=difft git log -p --ext-diff $@; }; f";
      rblame = "!git blame -w -M -C -C -C";
    };
    difftastic = {
      enable = true;
      background = "dark";
    };
  };
}
