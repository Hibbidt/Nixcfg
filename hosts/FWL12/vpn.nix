{config,lib, pkgs,...}:
{

  services.globalprotect = { # Easiest to use and most distros use this by default.P
    enable = true;  

  };
}
