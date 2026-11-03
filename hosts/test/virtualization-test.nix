{ ... }:

{
  virtualisation.vmVariant = {
    users.users.test = {
      isNormalUser = true;
      initialPassword = "test";
    };
  };
}
