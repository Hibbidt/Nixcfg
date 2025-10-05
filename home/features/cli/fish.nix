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


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function backup --argument filename
    cp $filename $filename.bak
end

# Fish command history
function history
    builtin history --show-time='%F %T '
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


