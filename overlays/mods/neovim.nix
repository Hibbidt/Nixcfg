{prev}:
prev.neovim.overrideAttrs (oldAttrs: rec {
  pname = oldAttrs.pname;

  src = prev.fetchFromGitHub {
    owner = "neovim";
    repo = "neovim";
    rev = "nightly";
    hash ="sha256-i8WUc3lip8YcsdpZ2xMeCqPy9z3dh85twT8Rn0udL1w=";
    #hash ="sha256-XtKjCeiJBxl3fVY3LwfIknZJHoRTZLMTQOyFIGSXT04=";

  };
})
