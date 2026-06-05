{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # secrets
  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/peter/.config/sops/age/keys.txt";

    secrets = {
      "ulla_backend/admin_password" = {
        owner = "ulla_backend";
      };

      "ulla_backend/db_path" = {
        owner = "ulla_backend";
      };
    };
  };

  # systemd service
  systemd.services."ulla_backend" = {
    description = "backend service of Ulla's portfolio";

    serviceConfig = {
      User = "ulla-backend";
      Group = "ulla_backend";

      WorkingDirectory = "/var/lib/ulla_backend";
      ExecStart = "/opt/ulla_backend/bin/ulla_backend";
      Restart = "on-failure";
      Environment = ''
        HOST = 0.0.0.0
        PORT = 8080
        ADMIN_PASSWORD = $(cat ${config.sops.secrets."ulla_backend/admin_password".path})
        STATIC_PATH = /var/lib/ulla_backend/static
        UPLOADS_PATH = /var/lib/ulla_backend/uploads
        DB_PATH = $(cat ${config.sops.secrets."ulla_backend/db_path".path})
        TEMP_PATH = /var/lib/ulla_backend/tmp
      '';
    };
  };

  # service user
  users = {
    users.ulla_backend = {
      home = "/var/lib/ulla_backend";
      createHome = true;
      isSystemUser = true;
      group = "ulla_backend";
    };
    groups.ulla_backend = { };
  };
}
