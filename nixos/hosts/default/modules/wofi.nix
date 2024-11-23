{ ... }:

{
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
}
