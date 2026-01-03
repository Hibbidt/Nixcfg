{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.nixvim;
in {
  options.features.cli.nixvim.enable = mkEnableOption "enable nixvim";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [nixvim];

    programs.nixvim = {
      enable = true;
    };
  };
}
