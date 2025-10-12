
{config,lib,...}:
with lib;
let
cfg = config.features.desktop.thunar;
in
{
    options.features.desktop.thunar.enable = mkEnableOption "thnar config";

    config = mkIf cfg.enable {

        programs.thunar  = {
            enable = true;


        };

    };
}
