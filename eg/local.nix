{pkgs, options, ...}:

{
  environment.sysConf = {
    git = {
      userName = "Rick Sanchez";
      email = "Rick.Sanchez@Wabalaba.dubdub";
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
        tmux
        vscodium
      ];
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
      gc = "nix store gc";
      localedit = "sudo vim /etc/nixos/local.nix";
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
