{ config, lib, pkgs, ... }:

let
  homelab = config.homelab;
in
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${homelab.mainUser.name}" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "docker" # Run docker without ‘sudo’
      "wheel" # Enable ‘sudo’ for the user.
    ];
    packages = config.homelab.mainUser.pkgs;
  };

  home-manager.users = {
    "${homelab.mainUser.name}" = { ... }:
    {
      home = {
        username = homelab.mainUser.name;
        homeDirectory = "/home/${homelab.mainUser.name}";
      };

      programs.git = {
        userName = config.homelab.git.userName;
        userEmail = config.homelab.git.email;
        extraConfig = {
          credential.helper = "cache --timeout=36000";
          core = {
            editor = "vi";
            autocrlf = "input";
          };
          color.ui = "always";
          init.defaultBranch = config.homelab.git.defaultBranch;
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
          push.autoSetupRemote = true;
          pull.rebase = true;

        };
        includes = lib.optionals homelab.git.createWorkspaces (
          map (ws: {
            condition = "gitdir:~/${ws.folderName}/";
            path = "~/${ws.folderName}/.gitconfig";
          }) homelab.git.workspaces
        );
      };

      home.file = lib.mkIf homelab.git.createWorkspaces (
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
          }) homelab.git.workspaces)
      );
    };
  };
}
