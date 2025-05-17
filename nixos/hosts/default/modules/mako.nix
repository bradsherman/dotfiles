{ ... }:

{
  services.mako = {
    enable = true;
    settings = {
      text-color = "#DCD7BA";
      background-color = "#2D4F67";
      border-color = "#1F1F28ee";
      border-size = 3;
      border-radius = 10;
      padding = 10;
      height = 400;
      width = 500;
      font = "SFNS Display 12";

      layer = "overlay";
      "default-timeout" = 5000;
      ignore-timeout = 0;
      icons = true;
      anchor = "top-right";
      sort = "+time";

      group-by = "app-name";
      format = ''
        <b>%a - %s</b>
        %b'';

      hidden = {
        format = "(and %h more)";
        "text-color" = "#C8C093";
      };

      "urgency=high" = {
        "background-color" = "#C34043";
        "border-color" = "#E82424";
      };
      "app-name=Slack" = {
        "default-timeout" = 10000;
        "group-by" = "summary";
      };
      "app-name=Spotify" = { "default-timeout" = 4000; };
      "app-name=swayidle" = { "default-timeout" = 10000; };
      "mode=do-not-disturb" = { invisible = true; };
    };
  };
}
