{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.mpv;
in {
  options.features.cli.mpv.enable = mkEnableOption "enable and configure mpv";

  config = mkIf cfg.enable {
    # home.packages = with pkgs; [ mpv ];

    programs.mpv = {
      enable = true;

      scripts = with pkgs.mpvScripts; [
        uosc
        thumbfast
        sponsorblock-minimal
        memo
        mpris
      ];

      config = {
        hwdec = "auto";
        demuxer-max-bytes = "256MiB";
      };

      scriptOpts = {};

      profiles = {
        music = {
          video = false;
          ytdl = true;
          ytdl-format = "bestaudio/best";
          volume = 35;
          shuffle = true;
          "profile-restore" = "copy-equal";
          "script-opts-append" = "memo-enabled=no";
        };

        ff2mpv = {
          speed = 2.00;
          volume = 100;
          pause = true;
          ytdl = true;
          ytdl-format = "all[height>=1080],bv[vcodec^=av]/bv[vcodes^=h2]/bv[vcodec^=vp],all[asr>=45000],ba[acodec=opus][abr>=95]";
        };
      };
    };
  };
}
