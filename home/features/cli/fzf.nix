
{config,lib,pkgs,...}:
with lib; 
let
cfg = config.features.cli.fzf;
in {
options.features.cli.fzf.enable = mkEnableOption "enable fzf";

config = mkIf cfg.enable {
home.packages = with pkgs; [fzf];

programs.fzf = {
    enable = true;
    defaultOptions = [
        "--preview='bat --color=always -n {}'"
        "--bind 'ctrl-/:toggle-preview'"
    ];
    defaultCommand = "fd --type f --exclude .git --follow --hidden";
    changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
};
};
}
