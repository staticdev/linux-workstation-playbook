{pkgs, ...}:
{
  environment.sysConf = {
    mainUser = "username";
    mainUserPkgs = with pkgs; [
      brave
      git
      htop
      tmux
      vscodium
    ];
    systemWidePkgs = with pkgs; [
      openssl
      vim
      wget
    ];
    timeZone = "Europe/Amsterdam";
  };
}
