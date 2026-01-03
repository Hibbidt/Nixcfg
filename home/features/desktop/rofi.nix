
{config,pkgs,lib,...}:
with lib;
let
cfg = config.features.desktop.rofi;
in
{
  options.features.desktop.rofi.enable = mkEnableOption "rofi config";

  config = mkIf cfg.enable {

    programs.rofi  = {
      enable = true;
      plugins = with pkgs; [rofi-calc rofi-file-browser];
      cycle = true;
#modes = [ "combi" "drun" "window" "ssh" "file-browser-extended" "calc" ];
      extraConfig = {

        kb-mode-next = "Control+Tab,Shift+Right";

        file-browser-cmd = "exo-open";
        file-browser-dir = "/";                  
        file-browser-depth = 0;                         
        file-browser-open-multi-key = "kb-accept-alt";
        file-browser-open-custom-key = "kb-custom-11";
        file-browser-hide-hidden-symbol = "";
        file-browser-path-sep = "/";
        file-browser-up-text = "up";
        file-browser-up-icon = "go-previous";
        file-browser-oc-search-path =  ""; 
        file-browser-exclude = "workspace";               

        no-show-match = true;
        no-sort= true;
        no-bold = true;




      };
      terminal = "kitty";
      location = "center";

    };

  };

}
