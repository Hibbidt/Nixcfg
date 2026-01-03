{config,lib,...}:
with lib;
let
cfg = config.features.desktop.flameshot;
in
{
  options.features.desktop.flameshot.enable = mkEnableOption "flameshot config";

  config = mkIf cfg.enable {

    services.flameshot  = {
      enable = true;
      settings ={
        General={
          useGrimAdapter = true;
          #savePath = "~/Pictures"; # not working
        }; 
      };

    };

  };

}

