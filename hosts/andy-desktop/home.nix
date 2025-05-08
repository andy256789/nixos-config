{ config, pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.stateVersion = "24.11";
    programs.fish.enable = true;
    programs.kitty.enable = true;
  };
}
