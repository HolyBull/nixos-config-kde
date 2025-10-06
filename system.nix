{ config, pkgs, ... }:

{
  # garbage collection - once a week clean all old generations except last 3
  nix.gc = {
    automatic = true;
    dates = "weekly";            # or "daily", "monthly", cron-style is allowed
    options = "--delete-older-than 7d";  # or "30d", etc.
  };
  boot.loader.systemd-boot.configurationLimit = 3; # keep only 3 boot entries

  # Enable and start the ExpressVPN systemd service
  systemd.services.expressvpn = {
    enable = true;
    description = "ExpressVPN background service";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.expressvpn}/bin/expressvpnd";
      Restart = "on-failure";
    };
  };

}
