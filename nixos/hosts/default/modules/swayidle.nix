{ pkgs, ... }:

{
  services.swayidle = {
    enable = true;
    package = pkgs.swayidle;
    timeouts = [
      {
        timeout = 270;
        command =
          "${pkgs.libnotify}/bin/notify-send --app-name=swayidle 'Locking in 30 seconds' -t 10000";
      }
      {
        timeout = 280;
        command =
          "${pkgs.libnotify}/bin/notify-send --app-name=swayidle 'Locking in 20 seconds' -t 10000";
      }
      {
        timeout = 290;
        command =
          "${pkgs.libnotify}/bin/notify-send -u critical --app-name=swayidle 'Locking in 10 seconds' -t 10000";
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
    events = [{
      event = "before-sleep";
      command = "${pkgs.swaylock-effects}/bin/swaylock";
    }];
  };
}
