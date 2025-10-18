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
                    AdvancedSettings = true;
                    ApplicationTheme = "dark";
                    HidePasswords = true;
                    CompactMode = false;
                    ColorPasswords = true;

                    };
                    Security = {
                Security_HideNotes = true;
                    };
                    };
            
            };

        };

    }
