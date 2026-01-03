
{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.eza;
in {
  options.features.cli.eza.enable = mkEnableOption "enable eza";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [eza];

    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };
  };
}
