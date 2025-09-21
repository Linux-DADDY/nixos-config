{
  config,
  lib,
  pkgs,
  ...
}: let
  l = lib; # alias for convenience
  persistentHomesRoot = "/persist/home";
  listOfCommands =
    l.mapAttrsToList
    (_: user: let
      userHome = l.escapeShellArg (persistentHomesRoot + "/" + user.name);
    in ''
      if [[ ! -d ${userHome} ]]; then
        echo "Persistent home folder '${userHome}' not found, creating..."
        mkdir -p --mode=${user.homeMode} ${userHome}
        chown ${user.name}:${user.group} ${userHome}
      fi
    '')
    (l.filterAttrs (_: user: user.createHome or false) config.users.users);
  stringOfCommands = l.concatStringsSep "\n" listOfCommands;
in {
  systemd.services."persist-home-create-root-paths" = {
    script = stringOfCommands;
    unitConfig = {
      Description = "Ensure users' home folders exist in the persistent filesystem";
      PartOf = ["local-fs.target"];
      After = ["persist-home.mount"]; # optional, if you have a mountpoint unit for /persist
    };
    serviceConfig = {
      Type = "oneshot";
      StandardOutput = "journal";
      StandardError = "journal";
    };
    wantedBy = ["local-fs.target"];
  };
}
