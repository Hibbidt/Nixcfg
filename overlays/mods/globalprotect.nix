{prev}:
prev.globalprotect.overrideAttrs (oldAttrs: rec {
  pname = oldAttrs.pname;
  version = "v2.4.7"

  src = prev.fetchFromGitHub {
    owner = "GlobalProtect-openconnect";
    repo = "yuezk";
    rev = "{version}";

    #hash = "sha256-7124edb0beaccd1568e4e905ab1030f617d16766";
  };
})
