{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.bat;
in {
options.features.cli.bat.enable = mkEnableOption "enable bat";

config = mkIf cfg.enable {
home.packages = with pkgs; [bat];

programs.bat = {
    enable = true;

};
};
}
