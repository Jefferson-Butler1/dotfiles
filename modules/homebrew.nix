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

    brews = [
      "ollama"
    ];

    casks = [
      "ghostty"
      "claude"
      "google-chrome"
      "raycast"
      "obsidian"
      "slack"
      "docker-desktop"
      "plex"
      "font-meslo-lg-nerd-font"
      "zen"
    ];
  };
}
