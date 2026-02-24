{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.features.desktop.mango.mango;
in {
  imports = [inputs.mango.hmModules.mango];

  options.features.desktop.mango.mango.enable = mkEnableOption "mango config";

  config = mkIf cfg.enable {
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        #xkb Keyboard setting
        xkb_rules_layout = de
        xkb_rules_options = lv3:caps_switch_capslock_with_ctrl

        # Keybinds
        bind=ALT,space,spawn, rofi -show drun -file-browser-depth 0 -theme Arc-Dark -run-command
        bind=SUPER,R,spawn,ghostty
        bind=SUPER,E,spawn,dolphin
        bind=SUPER,Q,killclient
        bind=SUPER,M,quit

        bind=SUPER,F,togglefullscreen

        #Layouts
        bind=SUPER,T,setlayout,tile
        bind=SUPER,F,setlayout,togglefloating
        bind=SUPER,G,setlayout,grid
        bind=SUPER,S,setlayout,scroller


        #DWM style binds
        bind=SUPER,i,incnmaster,+1
        bind=SUPER,d,incnmaster,-1
        bind=SUPER,h,setmfact,-0.05
        bind=SUPER,l,setmfact,+0.05
        bind=SUPER,RETURN,zoom

        #Swap Position of windows
        bind=SUPER+SHIFT,Up,exchange_client,up
        bind=SUPER+SHIFT,Down,exchange_client,down
        bind=SUPER+SHIFT,Left,exchange_client,left
        bind=SUPER+SHIFT,Right,exchange_client,right


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

        #switch window focus
        bind=SUPER,j,focusstack,next
        bind=SUPER,k,focusstack,prev

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
