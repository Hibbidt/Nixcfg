
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
          "--bind 'ctrl-/:toggle-preview'"
          "--preview='bat --color=always -n {}'"
          "--border=rounded"
          "--preview-window=border-rounded"
      ];
      defaultCommand = "fd --type f --exclude .git --follow --hidden";
      changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
    };
  };
}
