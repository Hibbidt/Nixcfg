{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.fzf;
in {
  options.features.cli.fzf.enable = mkEnableOption "enable fzf";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [fzf];

    programs.fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultOptions = [
        "--footer 'Press CTRL-Y to copy command into clipboard'"
        "--preview='bat --color=always -n {}'"
        "--preview-window=right:50%:border-rounded"
        "--bind 'ctrl-/:change-preview-window(right|down|)'"
        "--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'"
      ];
      defaultCommand = "fd --type f --exclude .git --follow --hidden";
      changeDirWidgetCommand = "fd --type d --exclude .git --follow --hidden";
    };
  };
}
