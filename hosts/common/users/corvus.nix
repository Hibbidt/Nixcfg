{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.corvus = {
    initialHashedPassword = "$y$j9T$My0PSozNkOkIr3hYTzlDa/$3baK/Mk/DQsrxC2sdQ7yC15yQOGkoLf.atW7I1VybE0";
    isNormalUser = true;
    description = "main-user";
    extraGroups = [
      "audio"
      "kvm"
      "libvirtd"
      "networkmanager"
      "qemu-libvirtd"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC3o/f2DwiJAxWpabwokaNoDCrO8upYE2WblMHyY8Kq1 simon@simon-garuda-mokka"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.corvus = import ../../../home/corvus/${config.networking.hostName}.nix;
}
