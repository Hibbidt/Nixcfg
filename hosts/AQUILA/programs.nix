{
  pkgs,
  config,
  lib,
  ...
}: {
  programs = {
    localsend.enable = true;
    fish.enable = true;
  };
}
