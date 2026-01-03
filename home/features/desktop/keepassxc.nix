{config,lib,...}:
with lib;
let
cfg = config.features.desktop.keepassxc;
in
{
    options.features.desktop.keepassxc.enable = mkEnableOption "keepassxc config";

    config = mkIf cfg.enable {

        programs.keepassxc  = {
            enable = true;

            settings = {
                Browser.Enabled = true;

                GUI = {
                    ApplicationTheme = "dark";
                    ColorPasswords = true;

                    };
                    Security = {
                        Security_HideNotes = true;
                    };
                    };
            
            };

        };

    }
