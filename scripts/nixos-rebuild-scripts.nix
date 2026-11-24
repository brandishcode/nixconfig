let
  adimnRequest = ''
    if [ "$(id -u)" -ne 0 ]; then
      exec sudo "$0" "$@"
    fi
  '';
in

{
  nixosRebuildTest =
    { writeShellScriptBin }:
    writeShellScriptBin "nrbt" (
      adimnRequest
      + ''
        nixos-rebuild test --flake .#B550I-AORUS-PRO-AX-rev-12
      ''
    );
  nixosRebuildSwitchProfile =
    { writeShellScriptBin }:
    writeShellScriptBin "nrbsp" (
      adimnRequest
      + ''
        nixos-rebuild switch -p $1 --flake .#B550I-AORUS-PRO-AX-rev-12
      ''
    );
}
