{ ... }:

let
  interface01 = "vpn_ph";
  interface02 = "vpn_jp";
  address = [
    "10.2.0.2/32"
    "2a07:b944::2:2/128"
  ];
  dns = [ "10.2.0.1" "2a07:b944::2:1" ];
  killSwitch = interface: {
    postUp = ''
      iptables -I OUTPUT ! -o ${interface} -m mark ! --mark $(wg show ${interface} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT  && ip6tables -I OUTPUT ! -o ${interface} -m mark ! --mark $(wg show ${interface} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
      '';
    preDown = ''
      iptables -D OUTPUT ! -o ${interface} -m mark ! --mark $(wg show ${interface} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -D OUTPUT ! -o ${interface} -m mark ! --mark $(wg show ${interface} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
      '';
  };
  in
{
  flake.nixosModules.amd_b550i = { config, ... }: {
    networking.wg-quick.interfaces = {
      ${interface01} =  {
        autostart = false;
        inherit address;
        inherit dns;
        privateKeyFile = config.sops.secrets."vpn/ph".path;
        peers = [
           {
              publicKey = "YHiExIkSK5Jqk/P6zO3UIDmf4B5NgClT2hqOXYCxD0g=";
              allowedIPs = [ "0.0.0.0/0" "::/0" ];
              endpoint = "188.214.125.162:51820";
              persistentKeepalive = 25;
           }
        ];
      } // (killSwitch interface01);
      ${interface02} =  {
        autostart = true;
        inherit address;
        inherit dns;
        privateKeyFile = config.sops.secrets."vpn/jp".path;
        peers = [
           {
              publicKey = "bPm9LS4EuRi+cXob6bCu1PnRS/VXzHlJl/1jULep1Xw=";
              allowedIPs = [ "0.0.0.0/0" "::/0" ];
              endpoint = "138.199.21.215:51820";
              persistentKeepalive = 25;
           }
        ];
      } // (killSwitch interface02);
    };
  };
}
