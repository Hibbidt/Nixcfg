{prev}:
prev.xournalpp.overrideAttrs (oldAttrs: rec {
  pname = oldAttrs.pname;

  src = prev.fetchFromGitHub {
    owner = "xournalpp";
    repo = "xournalpp";
    rev = "nightly";
    hash = "sha256-DkV9vm8IHyTshG76IwJpW8OA0RwTlVf2kiNb+IixDMU=";
    #hash = "sha256-fu7KyeRHzaWwws0bnj579HfaQScVV5+dsUPPkAmUNgQ=";
  };
  buildInputs = oldAttrs.buildInputs or [] ++ [prev.help2man prev.qpdf];

  postPatch = ''
    substituteInPlace src/util/Stacktrace.cpp --replace "addr2line" "new_value"
  '';
})
