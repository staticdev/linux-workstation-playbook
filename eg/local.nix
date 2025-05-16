{ pkgs, options, ... }:

{
  environment.sysConf = {
    dconf = {
      favoriteApps = [ "brave-browser.desktop" "org.gnome.Nautilus.desktop" "org.gnome.Terminal.desktop" ];
      # gnome extesions require wayland restart
      gnomeExtensions = with pkgs.gnomeExtensions; [
        appindicator
        tiling-assistant
        vitals
      ];
      guakeHotkey = "F12";
      hotCorners = false;
      keyboardLayout = [
          { layout = "us"; variant = "intl"; }
          { layout = "de"; variant = null; }
        ];
      lockScreenNotifications = false;
      nightLight = false;
    };
    git = {
      userName = "Rick Sanchez";
      email = "Rick.Sanchez@Wabalaba.dubdub";
      defaultBranch = "main";
      createWorkspaces = true;
      workspaces = [
        {
          folderName = "workspace_personal";
          email = "personal@example.com";
          userName = "Rick Personal";
        }
        {
          folderName = "workspace_work";
          email = "rick@rick.com";
          userName = "Rick Professional";
        }
      ];
    };
    mainUser = {
      name = "username";
      pkgs = with pkgs; [
        brave
        pkgs-unstable.devenv
        git
        htop
        obs-studio
        onlyoffice-desktopeditors
        thefuck
        tmux
        vscodium
        wl-clipboard
      ];
    };
    services = {
      enable = true;
      jellyfin.enable = true;
    };
    systemWidePkgs = with pkgs; [
      ansible
      openssl
      wget
    ];
    timeZone = "Europe/Amsterdam";
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # ublock origin
    ];
  };
  # fix issues with running ruff being dynamically linked
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = options.programs.nix-ld.libraries.default;
  # Neovim configs
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    colorschemes.vscode.enable = true;
    opts = {
      number = true;
      relativenumber = false;
      guicursor = "";
      undofile = true;
      encoding = "utf-8";
      signcolumn = "yes";
      belloff = "all";
      wrap = false;
      wildmenu = true;
      modeline = true;
      modelines = 1;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smarttab = true;
      autoindent = true;
    };
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      barbar.enable = true;
      lazygit.enable = true;
      gitblame.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      lastplace.enable = true;
      treesitter.enable = true;
      neo-tree.enable = true;
      nvim-autopairs.enable = true;
      helm.enable = true;
      cmp.enable = true;
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          clangd.enable = true;
        };
      };
    };
  };
  # Enable zsh in case you want to use it
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      clip = "wl-copy";
      cplocal = "viewlocal|clip";
      df = "df -h";
      editflake = "sudo nvim /etc/nixos/flake.nix";
      editlocal = "sudo nvim /etc/nixos/local.nix";
      viewflake = "cat /etc/nixos/flake.nix";
      viewlocal = "cat /etc/nixos/local.nix";
      mkdir = "mkdir -p";
      ngc = "nix store gc";
      # git aliases inspired on https://kapeli.com/cheat_sheets/Oh-My-Zsh_Git.docset/Contents/Resources/Documents/index
      ga = "git add";
      gac = "git acommit";
      gc = "git cm";
      gcf = "git config --list";
      gco = "git checkout";
      gf = "git fetch";
      gfa = "git fetch --all --prune";
      gfo = "git fetch origin";
      gfp = "git fpush";
      gl = "git l";
      gp = "git pull";
      gr = "git reset";
      grb = "git rebase";
      grba = "git rebase --abort";
      grbc = "git rebase --continue";
      gs = "git status";
      gsta = "git stash";
      gstaa = "git stash apply";
      gstl = "git stash list";
      la = "ls --color -lha";
      ls = "ls --color=auto";
      nixup = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch";
    };
    shellInit = ''
      if [ ! -f ~/.zshrc ]; then
        echo 'eval "$(direnv hook zsh)"' > ~/.zshrc
      fi
    '';
  };

  virtualisation = {
    libvirtd = {
      enable = true;
    };
    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.settings.dns_enabled = true;
    };
    docker.enable = true;
  };
}
