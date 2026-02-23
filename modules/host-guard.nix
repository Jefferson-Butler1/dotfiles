{ pkgs, ... }:

let
  enforceHostsScript = pkgs.writeShellScript "enforce-hosts" ''
    HOSTS="/etc/hosts"
    MARKER="# Addigy block"

    BLOCKS="$MARKER
    0.0.0.0 prod.addigy.com
    0.0.0.0 app.addigy.com
    0.0.0.0 agents.addigy.com
    0.0.0.0 mdm.addigy.com
    0.0.0.0 api.addigy.com
    0.0.0.0 login.addigy.com
    $MARKER end"

    ensure_blocks() {
      if ! grep -q "$MARKER" "$HOSTS"; then
        printf '%s\n' "$BLOCKS" >> "$HOSTS"
      fi
    }

    ensure_blocks

    while true; do
      sleep 30
      ensure_blocks
    done
  '';
in
{
  launchd.daemons.host-guard = {
    serviceConfig = {
      ProgramArguments = [ "${enforceHostsScript}" ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/var/log/host-guard.log";
      StandardErrorPath = "/var/log/host-guard.log";
    };
  };
}
