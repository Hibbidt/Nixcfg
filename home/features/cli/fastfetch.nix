{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.cli.fastfetch;
in
{
  options.features.cli.fastfetch.enable = mkEnableOption "enable fastfetch";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ fastfetch ];

    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          source = "nixos_small";
          padding = {
            right = 1;
          };
        };
        display = {
          size = {
            binaryPrefix = "si";
          };
          color = "blue";
          separator = "   ";
        };
        modules = [
          {
            type = "host";
            key = "System";
            keyColor = "yellow";
          }
          {
            type = "os";
            key = "Distro";
            keyColor = "yellow";
          }
          {
            type = "kernel";
            key = "Kernel";
            keyColor = "yellow";
          }
          {
            type = "GPU";
            key = "Gpu";
            keyColor = "yellow";
          }
          {
            type = "memory";
            key = "Ram";
            keyColor = "yellow";
          }
          {
            type = "swap";
            key = "Swap";
            keyColor = "yellow";
          }
          {
            type = "LocalIp";
            key = "IP";
            keyColor = "green";
          }
          {
            type = "packages";
            key = "Packages";
            keyColor = "magenta";

          }
          {
            type = "command";
            key = "OS Age";
            text = "birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days";
            keyColor = "magenta";
          }
          {
            type = "uptime";
            key = "Uptime";
            keyColor = "magenta";
          }
          {
            type = "datetime";
            key = "Date";
            format = "{11}-{3}-{1}";
            keyColor = "magenta";
          }
          {
            type = "datetime";
            key = "Time";
            format = "{14}:{17}:{20}";
            keyColor = "magenta";
          }

          "break"
          "player"
          "media"
        ];
      };

    };
  };

}
