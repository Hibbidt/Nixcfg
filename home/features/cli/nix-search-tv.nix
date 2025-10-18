{config, lib, pkgs,...}:
with lib;
let 
cfg = config.features.cli.nix-search-tv;
in
{
    options.features.cli.nix-search-tv.enable = mkEnableOption "enable nix-search-tv";

    config = mkIf cfg.enable {
            home.packages = with pkgs; [nix-search-tv];

            programs.nix-search-tv = {
                enable = true;
                enableTelevisionIntegration = true;
                };
        };
}
