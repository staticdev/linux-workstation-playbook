{ config, pkgs, ... }:

let
  mainUser = config.environment.sysConf.mainUser;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${mainUser.name}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "docker" # Run docker without ‘sudo’
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = config.environment.sysConf.mainUser.pkgs;
  };

  home-manager.users = {
    "${mainUser.name}" = { ... }:
    {
      home = {
        username = mainUser.name;
        homeDirectory = "/home/${mainUser.name}";
      };

      programs.git = {
        userName = config.environment.sysConf.git.userName;
        userEmail = config.environment.sysConf.git.email;
      };
    };
  };
}
