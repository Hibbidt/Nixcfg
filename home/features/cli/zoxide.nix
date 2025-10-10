
{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.zoxide;
in {
options.features.cli.zoxide.enable = mkEnableOption "enable zoxide";

config = mkIf cfg.enable {
home.packages = with pkgs; [zoxide];

programs.zoxide = {
enable = true;
options = ["--cmd cd"];
enableFishIntegration = true;
};

};
}

