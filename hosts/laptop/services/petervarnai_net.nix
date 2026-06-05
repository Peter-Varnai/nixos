{
  config,
  lib,
  pkgs,
  ...
}:

{
  systemd.services.sajat-weblap = {
    description = "backend service of my website";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "peter";
      WorkingDirectory = "/home/opt/petervarnai_net";
      ExecStart = "/home/opt/petervarnai_net/target/release/petervarnai_net";
      Restart = "always";
      RestartSec = "3s";

      Environment = [
        "HOST=127.0.0.1"
        "PORT=8080"
      ];
    };
  };
}
