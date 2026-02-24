{ pkgs, ... }:

{
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 128;
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
      orientation = "left";
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXPreferredViewStyle = "glyv";
      FXDefaultSearchScope = "SCev";
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      AppleShowAllExtensions = true;
      AppleInterfaceStyle = "Dark";
      NSAutomaticSpellingCorrectionEnabled = false;
      "com.apple.swipescrolldirection" = true;
    };

    CustomSystemPreferences = {
      "com.apple.WindowManager" = {
        HideDesktop = true;
      };
    };

    CustomUserPreferences = {
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "60" = { enabled = false; value = { parameters = [ 65535 65535 0 ]; type = "standard"; }; };
          "61" = { enabled = false; value = { parameters = [ 65535 65535 0 ]; type = "standard"; }; };
          "64" = { enabled = false; value = { parameters = [ 65535 65535 0 ]; type = "standard"; }; };
          "164" = { enabled = false; value = { parameters = [ 65535 65535 0 ]; type = "standard"; }; };
        };
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  networking.applicationFirewall = {
    enable = true;
    enableStealthMode = true;
  };

  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

  nix.enable = false;

  system.primaryUser = "jeff";
  system.stateVersion = 6;
  nixpkgs.config.allowUnfree = true;
}
