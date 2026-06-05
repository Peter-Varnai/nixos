{ pkgs, ... }:
{
  security.acme = {
    defaults = {
      email = "peter@varnai.dev";
      server = "https://acme-v02.api.letsencrypt.org/directory";
    };
  };

  services.nginx = {
    enable = true;
    recommendedTlsSettings = true;
    recommendedProxySettings = true;

    virtualHosts."ullarauter.com" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:8080";
      locations."/".proxyWebsockets = true;
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
