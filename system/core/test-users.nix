{
  config,
  username,
  inputs,
  ...
}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  # Enable OpenSSH
  services.openssh.enable = true;

  # Set identity paths (optional if using default host key)
  #age.identityPaths = ["/etc/ssh/ssh_host_ed25519_key"];

  age.secrets.user-password = {
    file = ../../secrets/user-password.age;
    #neededForUsers = true;
  };

  users.users.Real-Human-Test = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.user-password.path;
  };
}
