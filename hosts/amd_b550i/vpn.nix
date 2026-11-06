{ ... }:

let
  interface01 = "proton26";
in
{
  flake.nixosModules.amd_b550i = { config, ... }: {
    networking.wg-quick.interfaces = {
      ${interface01} =  {
        autostart = true;
        address = [
          "10.2.0.2/32"
          "2a07:b944::2:2/128"
        ];
        dns = [ "10.2.0.1" "2a07:b944::2:1" ];
        privateKeyFile = config.sops.secrets."vpn/protonvpn".path;
        peers = [
           {
              publicKey = "YHiExIkSK5Jqk/P6zO3UIDmf4B5NgClT2hqOXYCxD0g=";
              allowedIPs = [ "0.0.0.0/0" "::/0" ];
              endpoint = "188.214.125.162:51820";
              persistentKeepalive = 25;
           }
        ];
        postUp = ''
          iptables -I OUTPUT ! -o ${interface01} -m mark ! --mark $(wg show ${interface01} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT  && ip6tables -I OUTPUT ! -o ${interface01} -m mark ! --mark $(wg show ${interface01} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
          '';
        preDown = ''
          iptables -D OUTPUT ! -o ${interface01} -m mark ! --mark $(wg show ${interface01} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -D OUTPUT ! -o ${interface01} -m mark ! --mark $(wg show ${interface01} fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
          '';
      };
    };
  };
}
