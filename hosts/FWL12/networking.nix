{
  config,
  lib,
  pkgs,
  ...
}: {
  #Add Certificate for wifi
  # security.pki.certificates = [
  #   ''
  #     -----BEGIN CERTIFICATE-----
  #     MIIEMjCCAxqgAwIBAgIBATANBgkqhkiG9w0BAQUFADB7MQswCQYDVQQGEwJHQjEb
  #     MBkGA1UECAwSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHDAdTYWxmb3JkMRow
  #     GAYDVQQKDBFDb21vZG8gQ0EgTGltaXRlZDEhMB8GA1UEAwwYQUFBIENlcnRpZmlj
  #     YXRlIFNlcnZpY2VzMB4XDTA0MDEwMTAwMDAwMFoXDTI4MTIzMTIzNTk1OVowezEL
  #     MAkGA1UEBhMCR0IxGzAZBgNVBAgMEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
  #     BwwHU2FsZm9yZDEaMBgGA1UECgwRQ29tb2RvIENBIExpbWl0ZWQxITAfBgNVBAMM
  #     GEFBQSBDZXJ0aWZpY2F0ZSBTZXJ2aWNlczCCASIwDQYJKoZIhvcNAQEBBQADggEP
  #     ADCCAQoCggEBAL5AnfRu4ep2hxxNRUSOvkbIgwadwSr+GB+O5AL686tdUIoWMQua
  #     BtDFcCLNSS1UY8y2bmhGC1Pqy0wkwLxyTurxFa70VJoSCsN6sjNg4tqJVfMiWPPe
  #     3M/vg4aijJRPn2jymJBGhCfHdr/jzDUsi14HZGWCwEiwqJH5YZ92IFCokcdmtet4
  #     YgNW8IoaE+oxox6gmf049vYnMlhvB/VruPsUK6+3qszWY19zjNoFmag4qMsXeDZR
  #     rOme9Hg6jc8P2ULimAyrL58OAd7vn5lJ8S3frHRNG5i1R8XlKdH5kBjHYpy+g8cm
  #     ez6KJcfA3Z3mNWgQIJ2P2N7Sw4ScDV7oL8kCAwEAAaOBwDCBvTAdBgNVHQ4EFgQU
  #     oBEKIz6W8Qfs4q8p74Klf9AwpLQwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQF
  #     MAMBAf8wewYDVR0fBHQwcjA4oDagNIYyaHR0cDovL2NybC5jb21vZG9jYS5jb20v
  #     QUFBQ2VydGlmaWNhdGVTZXJ2aWNlcy5jcmwwNqA0oDKGMGh0dHA6Ly9jcmwuY29t
  #     b2RvLm5ldC9BQUFDZXJ0aWZpY2F0ZVNlcnZpY2VzLmNybDANBgkqhkiG9w0BAQUF
  #     AAOCAQEACFb8AvCb6P+k+tZ7xkSAzk/ExfYAWMymtrwUSWgEdujm7l3sAg9g1o1Q
  #     GE8mTgHj5rCl7r+8dFRBv/38ErjHT1r0iWAFf2C3BUrz9vHCv8S5dIa2LX1rzNLz
  #     Rt0vxuBqw8M0Ayx9lt1awg6nCpnBBYurDC/zXDrPbDdVCYfeU0BsWO/8tqtlbgT2
  #     G9w84FoVxp7Z8VlIMCFlA2zs6SFz7JsDoeA3raAVGI/6ugLOpyypEBMs1OUIJqsi
  #     l2D4kF501KKaU73yqWjgom7C12yxow+ev+to51byrvLjKzg6CYG1a4XXvi3tPxq3
  #     smPi9WIsgtRqAEFQ8TmDn5XpNpaYbg==
  #     -----END CERTIFICATE-----
  #     ''
  #     ];

  networking.networkmanager = {
    # Easiest to use and most distros use this by default.P
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
            uuid = "$UUID";
            type = "wifi";
            interface-name = "$INTER";
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
            uuid = "$UUID2";
            type = "wifi";
            interface-name = "$INTER";
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
            id = "mob";
            uuid = "$UUIDH";
            type = "wifi";
            interface-name = "$INTER";
            autoconnect = true;
          };
          wifi = {
            mode = "infrastructure";
            ssid = "$SSIDH";
          };
          wifi-security = {
            key-mgmt = "wpa-psk";
            psk = "$PSKH";
            auth-alg = "open";
          };
          ipv4 = {
            method = "auto";
          };
          ipv6 = {
            addr-gen-mode = "stable-privacy";
            method = "auto";
          };
        };

        edu = {
          "802-1x" = {
            anonymous-identity = "$AID";
            ca-cert = "/etc/ssl/certs/ca-bundle.crt";
            eap = "ttls;";
            identity = "$ID";
            password = "$IDPW";
            phase2-auth = "mschapv2";
          };
          connection = {
            id = "edu";
            interface-name = "$INTER";
            type = "wifi";
            uuid = "$UUIDID";
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
            ssid = "$SSIDID";
          };
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-eap";
          };
        };
      };
    };
  };
}
