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
      (
        pkgs.writeShellScriptBin "ns" (builtins.readFile (pkgs.nix-search-tv.src + "/nixpkgs.sh"))
        // {
          nativeBuildInputs = [pkgs.makeWrapper];
          postInstall = ''
            wrapProgram "$out/bin/ns" \
              --prefix PATH : ${
              lib.makeBinPath [
                pkgs.bash
                pkgs.fzf
                pkgs.nix-search-tv
                pkgs.coreutils
                pkgs.gnused
                pkgs.gawk
                pkgs.xdg-utils
                pkgs.nix
              ]
            }
          '';
        }
      )
    ];
    programs.nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
      settings = {};
    };
  };
}
