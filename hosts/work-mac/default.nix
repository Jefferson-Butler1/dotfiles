{ pkgs, rust-overlay, ... }:

{
  imports = [
    ../../modules/common.nix
    ../../modules/homebrew.nix
    ../../modules/home.nix
    ../../modules/host-guard.nix
    ../../modules/raycast.nix
  ];

  networking.hostName = "work-mac";
  nixpkgs.overlays = [ rust-overlay.overlays.default ];

  raycast = {
    enable = true;
    password = "12345678";

    preferences = {
      globalHotkey = "Command-Space";
      navigationStyle = "vim";
      textSize = "large";
      windowMode = "default";
    };

    appHotkeys = {
      "com.mitchellh.ghostty" = "Control-Option-Command-A";
      "com.tinyspeck.slackmacgap" = "Control-Option-Command-S";
      "app.zen-browser.zen" = "Control-Option-Command-D";
      "com.figma.Desktop" = "Control-Option-Command-F";
      "com.blacksaltgames.dredge" = "Control-Option-Command-G";
      "dev.zed.Zed" = "Control-Option-Command-Z";
      "com.anthropic.claudefordesktop" = "Control-Option-Command-C";
      "com.hnc.Discord" = "Control-Option-Command-V";
      "md.obsidian" = "Control-Option-Command-N";
      "com.spotify.client" = "Control-Option-Command-M";
      "com.apple.mail" = "Control-Option-Command-E";
      "com.apple.MobileSMS" = "Control-Option-Command-I";
      "io.tailscale.ipn.macos" = "Control-Option-Command-T";
      "app.yaak.desktop" = "Control-Option-Command-Y";
      "com.utmapp.UTM" = "Control-Option-Command-U";
      "tv.plex.desktop" = "Control-Option-Command-L";
      "at.eggerapps.Postico" = "Control-Option-Command-P";
      "com.apple.systempreferences" = "Control-Option-Command-,";
      "com.apple.Photos" = "Control-Option-Command-H";
      "com.electron.wispr-flow" = "Control-Option-Command-W";
    };

    windowManagement = {
      leftHalf = "Shift-Command-H";
      rightHalf = "Shift-Command-L";
      topHalf = "Shift-Command-I";
      bottomHalf = "Shift-Command-,";
      topLeftQuarter = "Shift-Command-U";
      topRightQuarter = "Shift-Command-O";
      bottomLeftQuarter = "Shift-Command-M";
      bottomRightQuarter = "Shift-Command-/";
      maximize = "Shift-Command-G";
      almostMaximize = "Shift-Command-J";
      toggleFullscreen = "Shift-Command-F";
      restore = "Shift-Command-K";
      reasonableSize = "Shift-Command-R";
      makeLarger = "Shift-Command-=";
      makeSmaller = "Shift-Command-.";
      maximizeHeight = "Shift-Command--";
      maximizeWidth = "Shift-Command-;";
      moveUp = "Shift-Command-W";
      moveDown = "Shift-Command-S";
      moveLeft = "Shift-Command-A";
      moveRight = "Shift-Command-D";
      nextDisplay = "Shift-Command-E";
      previousDesktop = "Shift-Command-N";
    };

    commandHotkeys = {
      clipboardHistory = "Shift-Control-P";
      searchEmoji = "Shift-Control-Space";
      quitAllApps = "Shift-Control-Esc";
      typingPractice = "Shift-Control-T";
      ejectAllDisks = "Shift-Control-E";
      confetti = "Shift-Control-Option-Command-1";
      windowBounceAnimation = "Shift-Control-Option-Command-2";
      preferencesExtensions = "Shift-Control-,";
      "quit-applications" = "Control-Option-Command-Esc";
      "kill-process.index" = "Shift-Control-K";
      "toggle-menu-bar.toggle" = "Shift-Control-M";
      "brew.clean-up" = "Shift-Control-C";
      "brew.search" = "Shift-Control-S";
      "brew.installed" = "Shift-Control-I";
      "brew.outdated" = "Shift-Control-O";
      "brew.upgrade" = "Shift-Control-U";
    };
  };
}
