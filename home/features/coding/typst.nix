{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.coding.typst;
in {
  options.features.coding.typst.enable = mkEnableOption "enable typst language";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.typst.withPackages (
        typkgs:
          with typkgs; [
            algo
            unify
            cetz
            cetz-plot
            mannot
          ]
      ))
    ];
  };
}
