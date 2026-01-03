{config,lib,pkgs,...}:
with lib;
let
cfg = config.features.desktop.flameshot;
lock-false = {
  Value = false;
  Status = "locked";
};
lock-true = {
  Value = true;
  Status = "locked";
};
in
{
  options.features.desktop.firefox.enable = mkEnableOption "firefox config";

  config = mkIf cfg.enable {

    programs.firefox  = {
      enable = true;


      package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
        extraPolicies = {
          DisableTelemetry = true;
          SearchEngines.Default =  "DuckDuckGo";
          OfferToSaveLogins = false;
          DisableFirefoxAccounts = true;
          translations.automaticallyPopup = false;
          # add policies here...

          /* ---- EXTENSIONS ---- */
          ExtensionSettings = {
            "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
              # uBlock Origin:
              "uBlock0@raymondhill.net" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
                installation_mode = "normal_installed";
              };
              # Dark Reader: 
              "addon@darkreader.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
                installation_mode = "normal_installed";
                };
              # Clear Ulr
              "{74145f27-f039-47ce-a470-a662b129930a}"={
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
                installation_mode = "normal_installed";
              };
              "keepassxc-browser@keepassxc.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
                installation_mode = "normal_installed";
              };
              "{b9b25e4a-bdf4-4270-868c-3f619eaf437d}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/no-pdf-download/latest.xpi";
                installation_mode = "normal_installed";
              };
              # add extensions here...
          };

          /* ---- PREFERENCES ---- */
          # Set preferences shared by all profiles.
          Preferences = { 
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
              # add global preferences here...
          };
        };
      };

      /* ---- PROFILES ---- */
      # Switch profiles via about:profiles page.
      # For options that are available in Home-Manager see
      # https://nix-community.github.io/home-manager/options.html#opt-programs.firefox.profiles
      profiles ={
        profile_0 = {           # choose a profile name; directory is /home/<user>/.mozilla/firefox/profile_0
          id = 0;               # 0 is the default profile; see also option "isDefault"
            name = "profile_0";   # name as listed in about:profiles
            isDefault = true;     # can be omitted; true if profile ID is 0
            settings = {          # specify profile-specific preferences here; check about:config for options
              "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
              #"browser.startup.homepage" = "https://nixos.org";
              #"browser.newtabpage.pinned" = [{
              #  title = "NixOS";
              #  url = "https://nixos.org";
              #}];
              # add preferences for profile_0 here...
            };
        };
      };
    };
  };
}
