{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.nix-search-tv;
in {
  options.features.cli.nix-search-tv.enable = mkEnableOption "enable nix-search-tv";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.nix-search-tv
      (pkgs.writeShellApplication {
        name = "ns";
        runtimeInputs = with pkgs; [
          fzf
          nix-search-tv
        ];
        checkPhase = "";
        text = builtins.replaceStrings ["ctrl-i"] ["ctrl-t"] (
          builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh"
        );
      })
    ];

    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      settings = {};
    };
  };
}
