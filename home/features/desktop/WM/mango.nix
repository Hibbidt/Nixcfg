{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.desktop.WM.mango;
in
{
  imports = [ inputs.mango.hmModules.mango ];

  options.features.desktop.WM.mango.enable = mkEnableOption "mango config";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      qt6.qtwayland
      quickshell
      blueberry
      networkmanagerapplet
      wireplumber
      pwvucontrol
      brightnessctl
      wf-recorder
      wl-mirror
      wl-clipboard
      wtype
      ydotool
    ];

    programs.waybar = {
      settings = {
        mainBar = {

          modules-left = [
            "custom/power_btn"
            "custom/lock_screen"
            "ext/workspaces"
          ];
          modules-center = [
            "idle_inhibitor"
            "clock"
            "custom/launch_rofi"
          ];
          modules-right = [
            "tray"
            "pulseaudio"
            "pulseaudio#microphone"
            "backlight"
            "bluetooth"
            "cpu"
            "memory"
            "temperature"
            "network"
            "battery"
          ];

        };
      };
    };

    wayland.windowManager.mango = {
      enable = true;

      autostart_sh = "";

      settings = ''
        #xkb Keyboard setting
        xkb_rules_layout = de
        xkb_rules_options = lv3:caps_switch_capslock_with_ctrl

        # Program keybinds
        bind=ALT,space,spawn, rofi -show drun -file-browser-depth 0 -theme Arc-Dark -run-command
        bind=SUPER,R,spawn,ghostty
        bind=SUPER,E,spawn,dolphin

        # Keybinds
        bind=SUPER,Q,killclient
        bind=SUPER+SHIFT,M,quit

        bind=SUPER,space,togglefullscreen

        #Function keys
        bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl s +2%
        bind=SHIFT,XF86MonBrightnessUp,spawn,brightnessctl s 100%
        bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl s 2%-
        bind=SHIFT,XF86MonBrightnessDown,spawn,brightnessctl s 10%

        #Layouts
        bind=SUPER,T,setlayout,tile
        bind=SUPER,F,setlayout,togglefloating
        bind=SUPER,G,setlayout,grid
        bind=SUPER,S,setlayout,scroller

        #DWM style binds
        bind=SUPER,b,incnmaster,+1
        bind=SUPER,n,incnmaster,-1
        bind=SUPER,i,setmfact,-0.05
        bind=SUPER,o,setmfact,+0.05
        bind=SUPER,RETURN,zoom

        #Swap Position of windows
        bind=SUPER+SHIFT,k,exchange_client,up
        bind=SUPER+SHIFT,j,exchange_client,down
        bind=SUPER+SHIFT,h,exchange_client,left
        bind=SUPER+SHIFT,l,exchange_client,right

        # Move the Window to the tag and switch to it
        bind=SUPER+SHIFT,1,tag,1
        bind=SUPER+SHIFT,2,tag,2
        bind=SUPER+SHIFT,3,tag,3
        bind=SUPER+SHIFT,4,tag,4
        bind=SUPER+SHIFT,5,tag,5
        bind=SUPER+SHIFT,6,tag,6
        bind=SUPER+SHIFT,7,tag,7
        bind=SUPER+SHIFT,8,tag,8
        bind=SUPER+SHIFT,9,tag,9

        # Workspaces if 1 number is pressed normal view if multiple are pressed then comboview
        bind=SUPER,1,comboview,1
        bind=SUPER,2,comboview,2
        bind=SUPER,3,comboview,3
        bind=SUPER,4,comboview,4
        bind=SUPER,5,comboview,5
        bind=SUPER,6,comboview,6
        bind=SUPER,7,comboview,7
        bind=SUPER,8,comboview,8
        bind=SUPER,9,comboview,9

        bind=SUPER,0,view,0 # Shows all Tags


        #switch window focus
        # stack wise
        bind=SUPER,tab,focusstack,next
        bind=SUPER+shift,tab,focusstack,prev

        # gerneral direction
        bind=SUPER,k,focusdir,up
        bind=SUPER,j,focusdir,down
        bind=SUPER,h,focusdir,left
        bind=SUPER,l,focusdir,right

        #Scratchpad
        #bind = SUPER,p,

        #Tag layouts and 4 persistent tags
        tagrule=id:1,layout_name:tile,no_hide:1
        tagrule=id:2,layout_name:tile,no_hide:1
        tagrule=id:3,layout_name:tile,no_hide:1
        tagrule=id:4,layout_name:tile,no_hide:1
        tagrule=id:5,layout_name:tile
        tagrule=id:6,layout_name:tile
        tagrule=id:7,layout_name:tile
        tagrule=id:8,layout_name:tile
        tagrule=id:9,layout_name:tile

        #Settings
        new_is_master=0
        enable_hotarea=0
        blur=0
        enable_floating_snap=1

        # Mouse Button Bindings
        # NONE mode key only work on ov mode
        mousebind=SUPER,btn_left,moveresize,curmove
        mousebind=SUPER,btn_right,moveresize,curresize

        #Eyecandy
        animations=0
        shadows=0
        gappih=3
        gappiv=3
        gappoh=3
        gappov=3
        borderpx=1
        no_border_when_single=1
      '';
    };
  };
}
