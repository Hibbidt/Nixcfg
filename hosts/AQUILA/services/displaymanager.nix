{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.displayManager.ly = {
    enable = true;
    x11Support = true;

    settings = {
      clock = "%c";
      waylandsessions = "${inputs.mango}/share/wayland-sessions";
      waylandsession = "mango";
    };
  };
}
