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
      first = {
        connection = {
          id = "first";
          type = "wifi";
          autoconnect = "true";
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

     second = {
         connection = {
             id = "second";
             type = "wifi";
             autoconnect = "true";
         };
         ipv4 = {
             method = "auto";
         };
         ipv6 = {
             addr-gen-mode = "stable-privacy";
             methond = "auto";
             };
             wifi = {
                 mode = "infrastructure";
                 ssid = "$SSID2";
                 };
             wifi-security = {
                 key-mgmt = "wpa-eap";
                 };
            "802-1x" = {
                eap = "peap";
                identity = "$ID";
                "ca-cert-password" = "$IDPW";
                "anonymous-identity" = "$AID";
                };
};
    };
  };
  };
}
