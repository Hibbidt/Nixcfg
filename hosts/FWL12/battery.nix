{lib,config,pkgs,...}:
{
# Should add Hibernate
  powerManagement = {
    enable = true;
  };
#Setting Hibernation settings and Power Button settings
#services.power-profiles-daemon.enable = true;
# Suspend first then hibernate when closing the lid
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";#-then-hibernate";
    # Hibernate on power button pressed
    HandlePowerKey = "suspend";#hibernate";
    HandlepowerKeyLongPress = "poweroff";
  };

  services.thermald = {
    enable = true;
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance" ;
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "pwerformance";

      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;

      TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;

    };
  };
}
