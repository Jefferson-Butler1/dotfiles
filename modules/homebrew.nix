{ ... }:

{
  homebrew = {
    enable = true;

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    taps = [];

    brews = [];

    casks = [
      "ghostty"
      "claude"
      "google-chrome"
      "raycast"
      "obsidian"
      "slack"
      "docker-desktop"
      "font-meslo-lg-nerd-font"
      "zen"
    ];
  };
}
