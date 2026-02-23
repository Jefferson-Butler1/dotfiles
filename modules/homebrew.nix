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
      "cursor"
      "zed"
      "google-chrome"
      "raycast"
      "obsidian"
      "slack"
      "docker"
      "font-meslo-lg-nerd-font"
      "zen"
    ];
  };
}
