{ config, lib, pkgs, ... }:

let
  sysConf = config.environment.sysConf;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${sysConf.mainUser.name}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "docker" # Run docker without ‘sudo’
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = config.environment.sysConf.mainUser.pkgs;
  };

  home-manager.users = {
    "${sysConf.mainUser.name}" = { ... }:
    {
      home = {
        username = sysConf.mainUser.name;
        homeDirectory = "/home/${sysConf.mainUser.name}";
      };

      programs.git = {
        userName = config.environment.sysConf.git.userName;
        userEmail = config.environment.sysConf.git.email;
        extraConfig = {
          credential.helper = "cache --timeout=36000";
          core = {
            editor = "vi";
            autocrlf = "input";
          };
          color.ui = "always";
          init.defaultBranch = config.environment.sysConf.git.defaultBranch;
          alias = {
            c = "commit";
            ca = "commit -a";
            cm = "commit -m";
            cam = "commit -am";
            d = "diff";
            dc = "diff --cached";
            graph = "log --graph --all --oneline";
            l = ''log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'';
            acommit = "commit --amend --no-edit --all";
            fpush = "push --force-with-lease";
          };
          pull.rebase = true;
          
        };
        includes = lib.optionals sysConf.git.createWorkspaces (
          map (ws: {
            condition = "gitdir:~/${ws.folderName}/";
            path = "~/${ws.folderName}/.gitconfig";
          }) sysConf.git.workspaces
        );
      };

      home.file = lib.mkIf sysConf.git.createWorkspaces (
        lib.listToAttrs (map (ws:
          {
            name = "${ws.folderName}/.gitconfig";
            value = {
              text = ''
                [user]
                  email = ${ws.email}
                  name = ${ws.userName}
              '';
            };
          }) sysConf.git.workspaces)
      );
    };
  };
}
