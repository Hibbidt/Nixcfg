{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.features.desktop.rofi;
in {
  options.features.desktop.rofi.enable = mkEnableOption "rofi config";

  config = mkIf cfg.enable {
    programs.rofi = with pkgs; {
      enable = true;
      package = rofi.override {
        plugins = [
          rofi-calc
          rofi-file-browser
        ];
      };

      terminal = "\${pkgs.ghostty}/bin/ghostty";
      extraConfig = {
        modi = "drun,file-browser-extended,calc,run";
        kb-primary-paste = "Control+V,Shift+Insert";
        kb-secondary-paste = "Control+v,Insert";

        no-show-match = true;
        no-sort = true;
        no-bold = true;
        show-icons = true;
        disable-history = false;
      };
    };
  };
}
