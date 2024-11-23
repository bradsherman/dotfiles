{ inputs, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
  };
}
