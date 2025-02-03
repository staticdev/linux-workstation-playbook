{pkgs, config, options, ...}:

let
  mainUser = config.environment.sysConf.mainUser;
in
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
      vim
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
  programs.firefox = {
    enable = true;
    policies = {
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
      ExtensionSettings = {
        # Blocks installing new extensions
        "*".installation_mode = "blocked";
        # uBlock Origin
        # https://addons.mozilla.org/api/v5/addons/addon/ublock-origin/
        "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
        };
        # Startpage
        # https://addons.mozilla.org/en-US/firefox/addon/startpage-private-search/
        "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4362482/startpage_private_search-2.0.2.xpi";
        installation_mode = "force_installed";
        };
      };
    };
  };
  # fix issues with running ruff being dynamically linked
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = options.programs.nix-ld.libraries.default;
  # Enable zsh in case you want to use it
  programs.zsh.enable = true;

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
