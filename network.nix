{ config, pkgs, ... }:

{
  networking.extraHosts = ''
  192.168.1.245   wdmycloud
  '';

  fileSystems."/mnt/nas" = {
  device = "//wdmycloud/Public";
  fsType = "cifs";
  options = [
      "guest"
      "uid=1000"
      "gid=1000"
      "dir_mode=0777"
      "file_mode=0777"
      "iocharset=utf8"
      "nounix"
      "noserverino"
      "x-systemd.automount"
      ];
    };
}
