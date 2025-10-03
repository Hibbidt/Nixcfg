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
set -U fish_greeting
# set VIRTUAL_ENV_DISABLE_ENV "1"
set -Ux MANPAGER 'nvim +Man!'
set -x NIX_PATH nixpkgs=channel:nixos-unstable
set -x NIX_LOG info
set -x TERMINAL kitty

if test (tty) = "/dev/tty1"
	exec Hyprland &> /dev/null
end
'';

shellAbbrs = {

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


