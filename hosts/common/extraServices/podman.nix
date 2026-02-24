{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.extraServices.podman;
in {
  options.extraServices.podman.enable = mkEnableOption "enable podman";
  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    environment.systemPackages = with pkgs; [podman-compose];
  };
}
