{ config, lib, pkgs, ... }:

let
  mainUser = config.environment.sysConf.mainUser;
  git_create_workspaces = true;
  git_workspaces = [
    {
      folder_name = "workspace1";
      email = "dev1@example.com";
      username = "Dev One";
    }
    {
      folder_name = "workspace2";
      email = "dev2@example.com";
      username = "Dev Two";
    }
  ];
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
        extraConfig = {
          credential.helper = "cache --timeout=36000";
          core = {
            editor = "vi";
            autocrlf = "input";
          };
          color.ui = "always";
          init.defaultBranch = config.environment.sysConf.git.defaultBranch;
          alias = {
            ac = "commit --amend --no-edit --all";
            fp = "push --force-with-lease";
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
        includes = lib.optionals git_create_workspaces (
          map (ws: {
            condition = "gitdir:~/${ws.folder_name}/";
            path = "~/${ws.folder_name}/.gitconfig";
          }) git_workspaces
        );
      };

      home.file = lib.mkIf git_create_workspaces (
        lib.listToAttrs (map (ws:
          {
            name = "${ws.folder_name}/.gitconfig";
            value = {
              text = ''
                [user]
                  email = ${ws.email}
                  name = ${ws.username}
              '';
            };
          }) git_workspaces)
      );
    };
  };
}
