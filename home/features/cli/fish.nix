{
config,
lib,
...
}: with lib; let
cfg = config.features.cli.fish;
in {

options.features.cli.fish.enable = mkEnableOption "enable extenden fish configuration";


config = mkIf cfg.enable

{

programs.fish = {
enable = true;
loginShellInit = ''
## Variables and settings
# disables the welcome message
set -U fish_greeting
# set VIRTUAL_ENV_DISABLE_ENV "1"

#sets nvim as man reader
set -Ux MANPAGER 'nvim +Man!'

set -x NIX_PATH nixpkgs=channel:nixos-unstable
set -x NIX_LOG info
set -x TERMINAL kitty

#executes hyprland when fish is being started on tty1
if test (tty) = "/dev/tty1"
	exec Hyprland &> /dev/null
end

'';

functions = {

  # Support for !! (last command) — from oh-my-fish bang-bang plugin
  __history_previous_command = ''
    switch (commandline -t)
      case "!"
        commandline -t $history[1]
        commandline -f repaint
      case "*"
        commandline -i "!"
    end
  '';

  # Support for !$ (last argument of last command)
  __history_previous_command_arguments = ''
    switch (commandline -t)
      case "!"
        commandline -t ""
        commandline -f history-token-search-backward
      case "*"
        commandline -i "$"
    end
  '';

  # Enhanced history command with timestamps
  hist = ''
    builtin history --show-time='%F %T  ' | nl -n ln
  '';

  # Create a backup: backup filename → filename.bak
  backup = ''
    cp $argv[1] $argv[1].bak
  '';

  # Smarter cp that handles directories better
  copy = ''
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
      set from (string trim --right --chars=/ -- $argv[1])
      set to $argv[2]
      command cp -r $from $to
    else
      command cp $argv
    end
  '';

};

interactiveShellInit = ''
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    bind -M insert ! __history_previous_command
    bind -M insert '$' __history_previous_command_arguments
  else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
  end
'';

shellAliases = {

# Replace ls with eza
"ls" = "eza -al --color=always --group-directories-first --icons"; # preferred listing
"lsz" = "eza -al --color=always --total-size --group-directories-first --icons"; # include file size
"la" = "eza -a --color=always --group-directories-first --icons";  # all files and dirs
"ll"= "eza -l --color=always --group-directories-first --icons";  # long format
"lt"= "eza -T --color=always --group-directories-first --icons"; # tree listing
"l."= "eza -ald --color=always --group-directories-first --icons .*"; # show only dotfiles

# Replace some more things with better alternatives
"cat" = "bat --style header --style snip --style changes --style header";
"grep" = "rg";
"ps" = "procs";

# Common use
".." = "cd ..";
"..." = "cd ../..";
"...." = "cd ../../..";
"....." ="cd ../../../..";
"......" ="cd ../../../../..";

"dir" =  "dir --color=auto";
"hw" =  "hwinfo --short"; # Hardware Info
"ip" =  "ip -color";
"psmem" = "ps auxf | sort -nr -k 4";
"psmem10"=  "ps auxf | sort -nr -k 4 | head -10";
"tarnow" = "tar -acf";
"untar" = "tar -zxvf";
"wget" = "wget -c";


# Get the error messages from journalctl
"jctl" = "journalctl -p 3 -xb";

};

};

};

}


