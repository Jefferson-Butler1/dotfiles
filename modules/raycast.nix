{ config, lib, pkgs, ... }:

let
  cfg = config.raycast;

  keycodes = {
    "A" = "0"; "S" = "1"; "D" = "2"; "F" = "3"; "H" = "4"; "G" = "5";
    "Z" = "6"; "X" = "7"; "C" = "8"; "V" = "9"; "B" = "11"; "Q" = "12";
    "W" = "13"; "E" = "14"; "R" = "15"; "Y" = "16"; "T" = "17";
    "1" = "18"; "2" = "19"; "3" = "20"; "=" = "24"; "-" = "25";
    "." = "27"; "O" = "31"; "U" = "32"; "[" = "33"; "I" = "34"; "P" = "35";
    "L" = "37"; "J" = "38"; "K" = "40"; ";" = "41"; "," = "43";
    "N" = "45"; "M" = "46"; "/" = "47"; "Space" = "49"; "~" = "50"; "Esc" = "53";
  };

  modifierNames = [ "Shift" "Control" "Option" "Command" ];

  toKeycode = hotkeyStr:
    let
      parts = lib.splitString "-" hotkeyStr;
      mods = builtins.filter (p: builtins.elem p modifierNames) parts;
      nonMods = builtins.filter (p: p != "" && !(builtins.elem p modifierNames)) parts;
      keyName =
        if nonMods == [] then "-"
        else lib.concatStringsSep "-" nonMods;
    in
      lib.concatStringsSep "-" (mods ++ [ keycodes.${keyName} ]);

  windowManagementKeys = {
    leftHalf = "builtin_command_windowManagementLeftHalf";
    rightHalf = "builtin_command_windowManagementRightHalf";
    topHalf = "builtin_command_windowManagementTopHalf";
    bottomHalf = "builtin_command_windowManagementBottomHalf";
    topLeftQuarter = "builtin_command_windowManagementTopLeftQuarter";
    topRightQuarter = "builtin_command_windowManagementTopRightQuarter";
    bottomLeftQuarter = "builtin_command_windowManagementBottomLeftQuarter";
    bottomRightQuarter = "builtin_command_windowManagementBottomRightQuarter";
    maximize = "builtin_command_windowManagementMaximize";
    almostMaximize = "builtin_command_windowManagementMaximizeAlmost";
    toggleFullscreen = "builtin_command_windowManagementToggleFullscreen";
    restore = "builtin_command_windowManagementRestore";
    reasonableSize = "builtin_command_windowManagementReasonableSize";
    makeLarger = "builtin_command_windowManagementMakeLarger";
    makeSmaller = "builtin_command_windowManagementMakeSmaller";
    maximizeHeight = "builtin_command_windowManagementMaximizeHeight";
    maximizeWidth = "builtin_command_windowManagementMaximizeWidth";
    moveUp = "builtin_command_windowManagementMoveUp";
    moveDown = "builtin_command_windowManagementMoveDown";
    moveLeft = "builtin_command_windowManagementMoveLeft";
    moveRight = "builtin_command_windowManagementMoveRight";
    nextDisplay = "builtin_command_windowManagementNextDisplay";
    previousDesktop = "builtin_command_windowManagementPreviousDesktop";
  };

  builtinCommandKeys = {
    clipboardHistory = "builtin_command_clipboardHistory";
    searchEmoji = "builtin_command_searchEmoji";
    quitAllApps = "builtin_command_quitAllApps";
    typingPractice = "builtin_command_typingPractice_start";
    ejectAllDisks = "builtin_command_ejectAllDisks";
    confetti = "builtin_command_confetti";
    windowBounceAnimation = "builtin_command_windowBounceAnimation";
    preferencesExtensions = "builtin_command_preferencesExtensions";
  };

  preferenceMap = {
    globalHotkey = { section = "preferencesGeneral"; key = "raycastGlobalHotkey"; };
    navigationStyle = { section = "preferencesAdvanced"; key = "navigationCommandStyleIdentifierKey"; };
    textSize = { section = "preferencesAppearance"; key = "raycastUI_preferredTextSize"; };
    windowMode = { section = "preferencesAppearance"; key = "raycastPreferredWindowMode"; };
  };

  mapPreferences = prefs:
    let
      grouped = lib.foldlAttrs (acc: name: value:
        let mapping = preferenceMap.${name}; in
        acc // {
          ${mapping.section} = (acc.${mapping.section} or {}) // {
            ${mapping.key} = value;
          };
        }
      ) {} prefs;
    in grouped;

  appItems = lib.mapAttrsToList (bundleId: hotkey: {
    key = bundleId;
    hotkey = toKeycode hotkey;
    type = "systemApp";
    match = "exact";
  }) cfg.appHotkeys;

  windowItems = lib.mapAttrsToList (name: hotkey: {
    key = windowManagementKeys.${name};
    hotkey = toKeycode hotkey;
    type = "command";
    match = "exact";
  }) cfg.windowManagement;

  commandItems = lib.mapAttrsToList (name: hotkey:
    if builtinCommandKeys ? ${name} then {
      key = builtinCommandKeys.${name};
      hotkey = toKeycode hotkey;
      type = "command";
      match = "exact";
    } else {
      key = "extension_${name}";
      hotkey = toKeycode hotkey;
      type = "nodeCommand";
      match = "prefix";
    }
  ) cfg.commandHotkeys;

  overlayJson = builtins.toJSON {
    rootSearch = appItems ++ windowItems ++ commandItems;
    preferences = mapPreferences cfg.preferences;
  };

  overlayFile = pkgs.writeText "raycast-overlay.json" overlayJson;

in {
  options.raycast = {
    enable = lib.mkEnableOption "Raycast declarative config management";

    password = lib.mkOption {
      type = lib.types.str;
      default = "12345678";
      description = "Raycast export encryption password.";
    };

    configDir = lib.mkOption {
      type = lib.types.str;
      default = "$HOME/dotfiles/raycast";
      description = "Directory containing .rayconfig exports.";
    };

    preferences = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Raycast preferences (globalHotkey, navigationStyle, textSize, windowMode).";
    };

    appHotkeys = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Bundle ID → hotkey mapping for app launchers.";
    };

    windowManagement = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Window management action → hotkey mapping.";
    };

    commandHotkeys = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Command name → hotkey mapping. Builtin commands use exact names; extensions use dotted names (e.g. brew.search).";
    };
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.postActivation.text = ''
      sudo -u jeff ${pkgs.fish}/bin/fish ${./raycast/merge-config.fish} \
        "${overlayFile}" \
        "${cfg.configDir}" \
        "${cfg.password}" \
        "${./raycast/merge.jq}"
    '';
  };
}
