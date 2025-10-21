{config,lib, pkgs,...}:
{

  networking.networkmanager = { # Easiest to use and most distros use this by default.P
      enable = true;  
      wifi.powersave = true;

  ensureProfiles = {
    environmentFiles = [
      config.age.secrets.NM.path
    ];

    profiles = {

      home = {
        connection = {
          id = "home";
          uuid="$UUID";
          type = "wifi";
          interface-name="$INTER";
          autoconnect = true;
        };
        ipv4 = {
          method = "auto";
        };
        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };
        wifi = {
          mode = "infrastructure";
          ssid = "$SSID";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$PSK";
        };
      };


     test = {
       connection = {
         id = "test";
         uuid="$UUID2";
         type = "wifi";
         interface-name="$INTER";
         autoconnect = true;
       };
       ipv4 = {
         method = "auto";
       };
       ipv6 = {
         addr-gen-mode = "stable-privacy";
         method = "auto";
       };
       wifi = {
         mode = "infrastructure";
         ssid = "$SSID2";
       };
       wifi-security = {
         key-mgmt = "wpa-psk";
         psk = "$PSK2";
       };
     };

     mob = {
         connection = {
            id="mob";
            uuid="$UUIDH";
            type="wifi";
            interface-name="$INTER";
            autoconnect = true;
            };
          wifi = {
            mode="infrastructure";
            ssid="$SSIDH";
            };
          wifi-security = {
            key-mgmt="wpa-psk";
            psk="$PSKH";
            auth-alg = "open";
            };
          ipv4 = {
            method="auto";
            };
          ipv6 = {
            addr-gen-mode="default";
            method="auto";
           };
         };

     edu = {
         connection = {
             id = "edu";
             uuid="$UUIDID";
             type = "wifi";
             interface-name="$INTER";
             autoconnect = true;
         };
         wifi = {
             ssid = "$SSIDID";
             mode = "infrastructure";
         };
         wifi-security = {
             key-mgmt = "wpa-eap";
             anonymous-identity = "$AID";
             eap = "peap";
             identity = "$ID";
             password = "$IDPW";
             phase2 = "auth=MSCHAPV2";
         };
     ipv4 = {
         method = "auto";
     };
     ipv6 = {
         addr-gen-mode = "default";
         method = "auto";
     };
   };
    };
  };
  };
}
