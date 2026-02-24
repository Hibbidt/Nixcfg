{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # xournalpp = import ./mods/xournalpp.nix {inherit prev;};
    # neovim = import ./mods/neovim.nix {inherit prev;};
    # globalprotect = import ./mods/globalprotect.nix {inherit prev;};
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  stable-packages = final: _prev: let
    inherit (final.stdenv-hostPlatform) system;
  in {
    stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
